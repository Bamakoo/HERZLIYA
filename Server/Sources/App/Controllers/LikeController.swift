import Fluent
import Vapor

// TODO: no need for a specific controller

struct LikeController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtectedLikes = routes.grouped(UserToken.authenticator())
            .grouped(UserToken.guardMiddleware())

        tokenProtectedLikes.get("likes", use: index)
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
        let likes = try await Like.query(on: req.db).with(\.$book).with(\.$user).all()
        return try likes.map { like in
            try GetLike(id: like.requireID(), userID: like.$user.id, bookID: like.$book.id, bookTitle: like.book.title, username: like.user.username)
        }
    }

    /// Creates a new instance of the Like object and saves it to the DB
    /// - Parameter req: the incoming request to /likes
    /// - Returns: a Response indicating wether the operation was successfully performed - or not
    func create(req: Request) async throws -> Response {

        guard let book = try await Book.find(req.parameters.get("bookID"), on: req.db),
              let bookID = book.id else {
            throw Abort(.notFound)
        }

        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }

        let realLike = Like(userID: userID, bookID: bookID)
        try await realLike.save(on: req.db)
        return try await realLike.encodeResponse(status: .created, for: req)
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

