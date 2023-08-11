import Fluent
import Vapor

// TODO: no need for a specific controller

struct LikeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedLikes = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())
        
        tokenProtectedLikes.get("likes", use: index)
        tokenProtectedLikes.put("likes", use: update)
        // TODO: does this belong in books?
        tokenProtectedLikes.post("likes", ":bookID", use: create)
        tokenProtectedLikes.group("likes", ":likeID") { like in
            like.delete(use: delete)
        }
    }
    
    // TODO: delete => X has liked Y book
    /// Function to GET an array of Like objects
    /// - Parameter req: the incoming request to /likes
    /// - Returns: an array of like objects
    func index(req: Request) async throws -> [GetLike] {
        let likes = try await Like.query(on: req.db).all()
        return try likes.map { like in
            try GetLike(id: like.requireID(), userID: like.$user.id, bookID: like.$book.id)
        }
    }
    
    /// Creates a new instance of the Like object and saves it to the DB
    /// - Parameter req: the incoming request to /likes
    /// - Returns: a Response indicating wether the operation was successfully performed - or not
    func create(req: Request) async throws -> Response {

        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db) else {
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
    
    // TODO: delete we won't be needing to update a like request
    func update(req: Request) async throws -> Response {
        let like = try req.content.decode(Like.self)
        
        guard let likeFromDB =  try await Like.find(like.id, on: req.db) else {
            throw Abort(.notFound)
        }
        
        likeFromDB.user = like.user

        try await likeFromDB.update(on: req.db)
        return try await likeFromDB.encodeResponse(status: .ok, for: req)
    }
    
    ///
    /// - Parameter req: the incoming DELETE request to /likes/:likeID
    /// - Returns: a Response
    func delete(req: Request) async throws -> Response {
        guard let like = try await Like.find(req.parameters.get("likeID"), on: req.db) else {
            throw Abort(.notFound)
        }
        try await like.delete(on: req.db)
        return try await like.encodeResponse(status: .ok, for: req)
    }
}

