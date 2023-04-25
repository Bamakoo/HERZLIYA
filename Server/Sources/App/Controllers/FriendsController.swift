import Fluent
import Vapor
// TODO: finish writing the controller for friends

struct FriendsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let passwordProtected = routes.grouped(User.authenticator())
            .grouped(UserToken.guardMiddleware())
        passwordProtected.get("friends", use: index)
        passwordProtected.post("friends", use: create)
    }
    func index(req: Request) async throws -> [Friend] {
        try await Friend.query(on: req.db).all()
    }
    
    func create(req: Request) async throws -> Friend {
        let friend = try req.content.decode(Friend.self)
        try await friend.save(on: req.db)
        return friend
    }
}
