import Fluent
import Vapor

// TODO: Perform Patch operations on all tables
// TODO: Search books by category
// TODO: exclude books I'm currently selling from the list of books I could purchase
// TODO: when a book status is purchased change status from available to purchased
// TODO: ask team wether operations should be supported on a particular book w/ :bookID

struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let unprotectedBooks = routes.grouped("books")
        unprotectedBooks.get(use: index)
        let unprotectedCategorySearch = routes.grouped("search", "books", "by-category", ":genre")
        
        unprotectedCategorySearch.get(use: categorySearchHandler)
        let tokenProtectedBooks = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedBooks.post("books", use: create)
        tokenProtectedBooks.patch("books", use: update)
        tokenProtectedBooks.group("books", ":bookID") { book in
            book.delete(use: delete)
        }
        tokenProtectedBooks.group("search", "books", ":search") { bookSearch in
            bookSearch.get(use: searchHandler)
        }
    }
    
    func searchHandler(req: Request) async throws -> [GetBook] {
        guard let searchTerm = req.parameters.get("search") else {
            throw Abort(.badRequest)
        }
        let books = try await Book.query(on: req.db).group(.or) { group in
            group.filter(\.$title =~ searchTerm).filter(\.$author =~ searchTerm)
        }
            .filter(\.$status == .available)
            .all()
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    func categorySearchHandler(req: Request) async throws -> [GetBook] {
        guard let realBookGenre = BookGenre(rawValue: req.parameters.get("genre") ?? "")
        else {
            throw Abort(.badRequest)
        }
        let books = try await Book.query(on: req.db).group(.and) { group in
            group.filter(\.$genre == realBookGenre)
                .filter(\.$status == .available)
        } .all()
        return try books.map { book in
            try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
        }
    }
    
    func index(req: Request) async throws -> [GetBook] {
        do {
            let search = try req.query.decode(Book.QueryFilter.self)
            print(search)
            let books = try await Book.query(on: req.db).group(.or) { group in
                group.filter(\.$genre == search.genre)
                    .filter(\.$status == .available)
            } .all()
            return try books.map { book in
                try GetBook(id: book.requireID(), title: book.title, author: book.author, price: book.price, state: book.state)
            }
        } catch {
            throw Abort(.badRequest)
        }
    }
    
    func create(req: Request) async throws -> ClientResponse {
        try Book.validate(content: req)
        let book = try req.content.decode(Book.self)
        try await book.save(on: req.db)
        guard let data = try? JSONEncoder().encode(book) else {
            return ClientResponse(status: .internalServerError, headers: [:], body: nil)
        }
        let byteBuffer = ByteBuffer(data: data)
        return ClientResponse(status: .created, headers: [:], body: byteBuffer)
    }
    
    func update(req: Request) async throws -> Book {
        // TODO: make it so that a user can't change a book if it's token doesn't belong to the user who sold the book
        let patchBook = try req.content.decode(PatchBook.self)
        guard let book  =  try await Book.find(patchBook.id, on: req.db) else {
            throw Abort(.notFound)
        }
        if let buyerID = patchBook.buyerID {
            book.$buyer.id = buyerID
        }
        if let title = patchBook.title {
            book.title = title
        }
        if let description = patchBook.description {
            book.description = description
        }
        if let state = patchBook.state {
            book.state = state
        }
        if let status = patchBook.status {
            book.status = status
        }
        if let price = patchBook.price {
            book.price = price
        }
        if let author = patchBook.author {
            book.author = author
        }
        if let genre = patchBook.genre {
            book.genre = genre
        }
        try await book.update(on: req.db)
        return book
    }
    func delete(req: Request) async throws -> HTTPStatus {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            print("unable to delete book")
            throw Abort(.notFound)
        }
        try await book.delete(on: req.db)
        return .ok
    }
}
