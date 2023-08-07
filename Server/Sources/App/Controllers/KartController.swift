import Fluent
import Vapor

struct KartController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedKarts = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        
        tokenProtectedKarts.get("karts", use: index)
        tokenProtectedKarts.put("karts", use: update)
        tokenProtectedKarts.post("karts", use: create)
        
        tokenProtectedKarts.post("karts", "add-book", ":bookID", use: addBookToKart)
        tokenProtectedKarts.delete("karts", "remove-book", ":bookID", use: removeBookFromKart)
        tokenProtectedKarts.group("karts", ":kartID") { kart in
            kart.delete(use: delete)
        }
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func removeBookFromKart(req: Request) async throws -> HTTPStatus {
        // get the user's ID and the book's ID
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db),
              let bookID = book.id
        else {
            print("unable to delete book")
            throw Abort(.notFound, reason: "unable to locate book")
        }        // get the user's Kart
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        guard let kart = try await Kart.query(on: req.db)
            .filter(\.$user.$id == userID)
            .first(),
              let kartID = kart.id
        else {
            throw Abort(.notFound, reason: "unable to find kart")
        }
        // find the book and the quart
        let kartBook = KartBook.query(on: req.db).group(.and) { group in
            group.filter(\.$kart.$id == kartID)
                .filter(\.$book.$id == bookID)
                .all()
        }
        try await kartBook.delete()
        return .ok
    }
    
    func addBookToKart(req: Request) async throws -> Response {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db),
              let bookID = book.id
        else {
            print("unable to delete book")
            throw Abort(.notFound)
        }
        
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        
        guard let kart = try await Kart.query(on: req.db)
            .filter(\.$user.$id == userID)
            .first(),
              let kartID = kart.id
        else {
            throw Abort(.notFound, reason: "unable to find kart")
        }
        
        let kartBook = KartBook(kartID: kartID, bookID: bookID)
        try await kartBook.save(on: req.db)
        return try await kartBook.encodeResponse(status: .ok, for: req)
    }
    
// TODO: move to /books/:bookID/add-to-kart
// TODO: delete all useless functions and endpoints
    func index(req: Request) async throws -> [Kart] {
        try await Kart.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Response {
        let kart = try req.content.decode(Kart.self)
        try await kart.save(on: req.db)
        return try await kart.encodeResponse(status: .created, for: req)
    }

    func update(req: Request) async throws -> Kart {
        let kart = try req.content.decode(Kart.self)
        
        guard let kartFromDB =  try await Kart.find(kart.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        kartFromDB.id = kart.id
        kartFromDB.user = kart.user

        try await kartFromDB.update(on: req.db)
        return kartFromDB
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let kart = try await Kart.find(req.parameters.get("kartID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await kart.delete(on: req.db)
        return .ok
    }
}
