import Fluent
import Vapor

struct FriendsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let friendRoutes = routes.grouped("friends")
        friendRoutes.get(use: index)
        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuth = friendRoutes.grouped(tokenAuthenticator, tokenMiddleware)
        tokenAuth.delete(":friendID", use: delete)
        tokenAuth.post("friends", use: create)
    }

    func delete(req: Request) async throws -> Response {
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        
        guard let friend = try await Friend.find(req.parameters.get("friendID"), on: req.db) else {
            throw Abort(.notFound)
        }
        
        guard userID == friend.$user.id else {
            throw Abort(.forbidden)
        }
        
        try await friend.delete(on: req.db)
        return try await friend.encodeResponse(status: .ok, for: req)
    }

    /// Returns an array of Friend objects
    /// - Parameter req: GET request on /friends
    /// - Returns: an array of Friend objects
    func index(req: Request) async throws -> [Friend] {
        try await Friend.query(on: req.db).all()
    }

    /// Creates a friends relationship between two users
    /// - Parameter req: the incoming POST request to /friends
    /// - Returns: a Response
    func create(req: Request) async throws -> Response {
        let friend = try req.content.decode(Friend.self)
        try await friend.save(on: req.db)
        return try await friend.encodeResponse(status: .created, for: req)
    }
}
