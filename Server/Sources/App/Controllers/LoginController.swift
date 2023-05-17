import Fluent
import Vapor


struct LoginController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let passwordProtected = routes.grouped(User.authenticator())
        passwordProtected.post("login") { req async throws -> PostUserToken in
            let user = try req.auth.require(User.self)
            let token = try user.generateToken()
            try await token.save(on: req.db)
            return PostUserToken(userID: token.$user.id, value: token.value)
        }
    }
}
