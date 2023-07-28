import Fluent
import Vapor

struct FriendsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let friendRoutes = routes.grouped("friends")
        friendRoutes.get(use: index)
        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuth = friendRoutes.grouped(tokenAuthenticator, tokenMiddleware)
        tokenAuth.get(":userID", use: getUsersFriends)
        tokenAuth.patch(":friendID", use: update)
        tokenAuth.post("friends", use: create)
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func getUsersFriends(req: Request) async throws -> [User] {
        guard let user = try await User.find(req.parameters.get("userID", as: UUID.self), on: req.db) else {
            throw Abort(.notFound, reason: "unable to locate the UserID")
        }
        return try await user.$usersFriends.get(on: req.db)
    }
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func index(req: Request) async throws -> [Friend] {
        try await Friend.query(on: req.db).all()
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
    func create(req: Request) async throws -> Response {
        let friend = try req.content.decode(Friend.self)
        try await friend.save(on: req.db)
        return try await friend.encodeResponse(status: .created, for: req)
    }
}
