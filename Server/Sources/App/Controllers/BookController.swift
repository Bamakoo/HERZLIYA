import Fluent
import Vapor

struct PatchBook: Codable {
    let id: UUID
    
    let author: String?
    let orderID: UUID?
    
    let title: String?
    let genre: String?
    let price: Int?
}

struct BookController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let books = routes.grouped("books")
        books.get(use: index)
        books.patch(use: update)
        books.post(use: create)
        books.group(":bookID") { book in
            book.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Book] {
        try await Book.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Book {
        let book = try req.content.decode(Book.self)
        try await book.save(on: req.db)
        return book
    }
    
    func update(req: Request) async throws -> Book {
        let patchBook = try req.content.decode(PatchBook.self)
        
        guard let book =  try await Book.find(patchBook.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        if let author = patchBook.author {
            book.author = author
        }
        
        if let orderID = patchBook.orderID {
            book.$order.id = orderID
        }
        
        if let title = patchBook.title {
            book.title = title
        }
        
        if let price = patchBook.price {
            book.price = price
        }
        
        if let genre = patchBook.genre {
            book.genre = genre
        }

        try await book.update(on: req.db)
        return book
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await book.delete(on: req.db)
        return .ok
    }
}
