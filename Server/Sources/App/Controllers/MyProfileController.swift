import Fluent
import Vapor

struct MyProfileController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {

        let myRoutes = routes.grouped("my")

        let tokenAuthenticator = UserToken.authenticator()
        let tokenMiddleware = UserToken.guardMiddleware()
        let tokenAuth = myRoutes.grouped(tokenAuthenticator, tokenMiddleware)

        tokenAuth.get(use: myProfile)
        // TODO: my ratings
    }

    func myProfile(req: Request) async throws -> User {
        try req.auth.require(User.self)
    }
}
