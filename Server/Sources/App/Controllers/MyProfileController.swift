import Fluent
import Vapor

struct MyProfileController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let tokenProtected = routes.grouped(UserToken.authenticator())
        tokenProtected.get("me") { req -> User in
            try req.auth.require(User.self)
        }
    }
}
