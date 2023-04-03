import Fluent
import Vapor

struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let unprotectedBooks = routes.grouped("books")
        unprotectedBooks.get(use: index)
        let tokenProtectedBooks = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedBooks.post("books", use: create)
        tokenProtectedBooks.put("books", use: update)
        // TODO: proper routing search feature with filters
        tokenProtectedBooks.group("books", ":bookID") { book in
            book.delete(use: delete)
        }
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
        let book = try req.content.decode(Book.self)
        guard let bookFromDB =  try await Book.find(book.id, on: req.db) else {
            throw Abort(.notFound)
        }
        bookFromDB.id = book.id
        bookFromDB.description = book.description
        bookFromDB.state = book.state
        bookFromDB.seller = book.seller
        bookFromDB.buyer = book.buyer
        bookFromDB.kart = book.kart
        bookFromDB.status = book.status
        bookFromDB.title = book.title
        bookFromDB.price = book.price
        bookFromDB.author = book.author
        bookFromDB.genre = book.genre
        try await bookFromDB.update(on: req.db)
        return bookFromDB
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
