import Fluent
import Vapor
// TODO: finish writing the controller for friends

struct FriendsController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let passwordProtected = routes.grouped(User.authenticator())
            .grouped(UserToken.guardMiddleware())
        passwordProtected.get("friends", use: index)
    }
        func index(req: Request) async throws -> [Friend] {
            try await Friend.query(on: req.db).all()
        }
    }
