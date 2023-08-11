import Fluent
import Vapor

struct FriendsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let friendRoutes = routes.grouped("friends")
        friendRoutes.get(use: index)
        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuth = friendRoutes.grouped(tokenAuthenticator, tokenMiddleware)
        tokenAuth.patch(":friendID", use: update)
        tokenAuth.post("friends", use: create)
    }
    
    /// <#Description#>
    /// - Parameter req: <#req description#>
    /// - Returns: <#description#>
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
