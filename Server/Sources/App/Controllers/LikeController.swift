import Fluent
import Vapor

// TODO: no need for a specific controller

struct LikeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedLikes = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        
        tokenProtectedLikes.get("likes", use: index)
        tokenProtectedLikes.put("likes", use: update)
        tokenProtectedLikes.post("likes", ":bookID", use: create)
        tokenProtectedLikes.group("likes", ":likeID") { like in
            like.delete(use: delete)
        }
    }
    
    func index(req: Request) async throws -> [Like] {
        try await Like.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Response {
        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
            print("unable to delete book")
            throw Abort(.notFound)
        }
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        let realLike = Like(userID: userID, bookID: try book.requireID())
        try await realLike.save(on: req.db)
        return try await realLike.encodeResponse(status: .created, for: req)
    }
    
    func update(req: Request) async throws -> Like {
        let like = try req.content.decode(Like.self)
        
        guard let likeFromDB =  try await Like.find(like.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        likeFromDB.user = like.user

        try await likeFromDB.update(on: req.db)
        return likeFromDB
    }

    func delete(req: Request) async throws -> HTTPStatus {
        guard let like = try await Like.find(req.parameters.get("likeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await like.delete(on: req.db)
        return .ok
    }
}

