import Fluent
import Vapor

struct AuthorController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let authors = routes.grouped("authors")
        authors.get(use: index)
        authors.put(use: update)
        authors.post(use: create)
        authors.group(":authorID") { author in
            author.delete(use: delete)
        }
    }

    func index(req: Request) async throws -> [Author] {
        try await Author.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Author {
        let author = try req.content.decode(Author.self)
        try await author.save(on: req.db)
        return author
    }
    
    func update(req: Request) async throws -> Author {
        let author = try req.content.decode(Author.self)
        
        guard let authorFromDB =  try await Author.find(author.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        authorFromDB.firstName = author.firstName
        authorFromDB.lastName = author.lastName

        try await authorFromDB.update(on: req.db)
        return authorFromDB
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let author = try await Author.find(req.parameters.get("authorID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await author.delete(on: req.db)
        return .ok
    }
}
