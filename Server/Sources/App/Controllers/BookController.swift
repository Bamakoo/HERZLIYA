import Fluent
import Vapor
// TODO: Perform Patch operations
// TODO: Search books by category

struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let unprotectedBooks = routes.grouped("books")
        unprotectedBooks.get(use: index)
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
    func searchHandler(req: Request) async throws -> [Book] {
        guard let searchTerm = req.parameters.get("search") else {
            throw Abort(.badRequest)
        }
        let books = try await Book.query(on: req.db)
            .filter(\.$title =~ searchTerm)
            .all()
        return books
    }
    func index(req: Request) async throws -> [Book] {
        try await Book.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Book {
        try Book.validate(content: req)
        let book = try req.content.decode(Book.self)
        try await book.save(on: req.db)
        return book
    }
    
    func update(req: Request) async throws -> Book {
        let patchBook = try req.content.decode(PatchBook.self)
        guard let book  =  try await Book.find(patchBook.id, on: req.db) else {
            throw Abort(.notFound)
        }
        if let buyerID = patchBook.buyerID {
            book.$buyer.id = buyerID
        }
        if let kartID = patchBook.kartID {
            book.$kart.id = kartID
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
