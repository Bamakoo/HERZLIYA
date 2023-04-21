import Fluent
import Vapor

// TODO: Perform Patch operations on all tables
// TODO: Search books by category
// TODO: exclude books I'm currently selling from the list of books I could purchase
// TODO: when a book status is purchased change status from available to purchased
// TODO: ask team wether operations should be supported on a particular book w/ :bookID
// TODO: refactor with routes.grouped("api", "acronyms")
// TODO: check that people can't buy their own books
// TODO: Use DataDome SDK
// TODO: change password feature

struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let unprotectedBooks = routes.grouped("books")
        unprotectedBooks.get(use: index)
        let unprotectedCategorySearch = routes.grouped("search", "books", "by-category", ":genre")
        unprotectedCategorySearch.get(use: categorySearchHandler)
        let tokenProtectedBooks = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedBooks.get("bought-books", ":userID", use: getUserBoughtBooks)
        tokenProtectedBooks.get("sold-books", ":userID", use: getUserSoldBooks)
        tokenProtectedBooks.get("favorite-authors-books", ":userID", use: getMyFavoriteAuthorsBooks)
        tokenProtectedBooks.post("books", use: create)
        tokenProtectedBooks.patch("books", use: update)
        tokenProtectedBooks.group("books", ":bookID") { book in
            book.get(use: getAParticularBook)
            book.patch(use: update)
            book.delete(use: delete)
        }
        tokenProtectedBooks.group("search", "books", ":search") { bookSearch in
            bookSearch.get(use: searchHandler)
        }
    }
    
    /// The function that handles all GET requests to the /favorite-authors-books/:userID endpoint
    /// - Parameter req: the incoming HTTP request
    /// - Returns: an array of books written by a user's favorite author
    func getMyFavoriteAuthorsBooks(req: Request) async throws -> [Book] {
        guard let user = try await User.find(req.parameters.get("userID", as: UUID.self), on: req.db) else {
            throw Abort(.notFound, reason: "unable to get the user ID to retrive all the currently available books for your favorite author")
        }
        return try await Book.query(on: req.db).group(.and) { group in
            group.filter(\.$author == user.favoriteAuthor)
                .filter(\.$status == .available)
        } .all()
    }
    
    /// The function called by the controller when the /book/:userID route is called
    /// - Parameter req: the incoming request, sent from the Client to the Server
    /// - Returns: An array of books the user has purchased
    func getUserBoughtBooks(req: Request) async throws -> [Book] {
        guard let user = try await User.find(req.parameters.get("userID", as: UUID.self), on: req.db) else {
            throw Abort(.notFound, reason: "unable to get the user ID for the baught books")
        }
        return try await user.$baughtBooks.get(on: req.db)
    }
    
    /// The function called by the controller when the /book/:userID route is called
    /// - Parameter req: the incoming request, received by the server
    /// - Returns: an array of Book objects the user has sold
    func getUserSoldBooks(req: Request) async throws -> [Book] {
        guard let user = try await User.find(req.parameters.get("userID", as: UUID.self), on: req.db) else {
            throw Abort(.notFound, reason: "unable to locate the UserID to get the users sold books")
        }
        return try await user.$soldBooks.get(on: req.db)
    }
    
    func getAParticularBook(req: Request) async throws -> Book {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            print("unable to get a specific book")
            throw Abort(.notFound)
        }
        return book
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
            let books = try await Book.query(on: req.db).group(.and) { group in
                if let genre = search.genre {
                    group.filter(\.$genre == genre)
                }
                if let state = search.state {
                    group.filter(\.$state == state)
                }
                if let title = search.title {
                    group.filter(\.$title == title)
                }
                if let author = search.author {
                    group.filter(\.$author == author)
                }
                if let price = search.price {
                    group.filter(\.$price == price)
                }
                group.filter(\.$status == .available)
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
        let book = try req.content.decode(CreateBookData.self)
        let realBook = Book(title: book.title,
                            author: book.author,
                            description: book.description,
                            genre: book.genre,
                            state: book.state,
                            price: book.price,
                            sellerID: book.sellerID,
                            buyerID: book.buyerID,
                            status: book.status)
        try await realBook.save(on: req.db)
        guard let data = try? JSONEncoder().encode(realBook) else {
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
