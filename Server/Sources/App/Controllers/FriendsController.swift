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
        tokenAuth.post(":friendID", use: create)
    }
    
    func index(req: Request) async throws -> [Friend] {
        return try await Friend.query(on: req.db)
            .all()
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

    /// Creates a friends relationship between two users
    /// - Parameter req: the incoming POST request to /friends
    /// - Returns: a Response
    func create(req: Request) async throws -> Response {
        let user = try req.auth.require(User.self)
        guard let userID = user.id else {
            throw Abort(.badRequest, reason: "unable to get user")
        }
        
        guard let friend = try await User.find(req.parameters.get("friendID"), on: req.db),
              let friendID = friend.id else {
            throw Abort(.notFound)
        }
        let realFriend = try Friend(userID: userID, usersFriendID: friendID)
        try await realFriend.save(on: req.db)
        return try await realFriend.encodeResponse(status: .created, for: req)
    }
}
