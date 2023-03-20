import Vapor

struct BasicUserAuthenticator: AsyncBasicAuthenticator {
    typealias User = App.User
    
    func authenticate(
        basic: BasicAuthorization,
        for request: Request
    ) async throws {
        let user = try request.content.decode(User.self)
        if basic.username == user.username && basic.password == user.passwordHash {
            request.auth.login(user)
        }
    }
}
