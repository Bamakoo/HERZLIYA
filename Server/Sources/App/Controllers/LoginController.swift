import Fluent
import Vapor


struct LoginController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        // TODO: a token can be used as a login 
        let passwordProtected = routes.grouped(User.authenticator())
        passwordProtected.post("login") { req async throws -> UserToken in
            let user = try req.auth.require(User.self)
            let token = try user.generateToken()
            try await token.save(on: req.db)
            return token
        }
    }
}
