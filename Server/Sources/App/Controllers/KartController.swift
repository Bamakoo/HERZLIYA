import Fluent
import Vapor

struct KartController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedKarts = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedKarts.get("karts", use: index)
        tokenProtectedKarts.put("karts", use: update)
        tokenProtectedKarts.post("karts", use: create)
        tokenProtectedKarts.post("add", "book", ":bookID", "user-kart", ":userID", use: addBookToUserKart)
        tokenProtectedKarts.group("karts", ":kartID") { kart in
            kart.delete(use: delete)
        }
    }
    
    func addBookToUserKart(req: Request) async throws -> Response {
        guard let user = try await User.find(req.parameters.get("userID", as: UUID.self), on: req.db),
              let userID = user.id else {
            throw Abort(.notFound, reason: "unable to locate the User")
        }
        guard let kart = try await Kart.query(on: req.db)
            .filter(\.$user.$id == userID)
            .first(),
              let kartID = kart.id
        else {
            throw Abort(.notFound, reason: "unable to find kart")
        }
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db),
              let bookID = book.id
        else {
            print("unable to delete book")
            throw Abort(.notFound)
        }
        let kartBook = KartBook(kartID: kartID, bookID: bookID)
        try await kartBook.save(on: req.db)
        return try await kartBook.encodeResponse(status: .ok, for: req)
    }

    func index(req: Request) async throws -> [Kart] {
        try await Kart.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Response {
        let kart = try req.content.decode(Kart.self)
        try await kart.save(on: req.db)
        return try await kart.encodeResponse(status: .created, for: req)
    }
    // TODO: implement patch on a kart object
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
