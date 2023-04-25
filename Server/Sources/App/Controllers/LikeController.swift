import Fluent
import Vapor

struct LikeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedLikes = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        tokenProtectedLikes.get("likes", use: index)
        tokenProtectedLikes.get("likes", ":userID", use: getAllUserLikes)
        tokenProtectedLikes.put("likes", use: update)
        tokenProtectedLikes.post("likes", use: create)
        tokenProtectedLikes.group("likes", ":likeID") { like in
            like.delete(use: delete)
        }
    }
    
    /// When called by the route handler this function returns an array of Like objects corresponding to a particular users' ID
    /// - Parameter req: the incoming GET request on /likes/:userID
    /// - Returns: an array of Like objects that a particular user has done
    func getAllUserLikes(req: Request) async throws -> [Like] {
        guard let userID = req.parameters.get("userID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Invalid user ID to get a user's likes")
        }
        return try await Like.query(on: req.db)
            .filter(\.$user.$id == userID)
            .with(\.$user)
            .with(\.$book)
            .all()
    }
    
    func index(req: Request) async throws -> [Like] {
        try await Like.query(on: req.db).all()
    }

    func create(req: Request) async throws -> Like {
        let like = try req.content.decode(Like.self)
        try await like.save(on: req.db)
        return like
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

