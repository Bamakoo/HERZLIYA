import Vapor

struct BasicUserAuthenticator: AsyncBasicAuthenticator {
    typealias User = App.User
    
    func authenticate(
        basic: BasicAuthorization,
        for request: Request
    ) async throws {
        let user = try request.content.decode(User.self)
        let passwordHashesMatch = try user.verify(password: basic.password)
        if basic.username == user.username && passwordHashesMatch {
            request.auth.login(user)
        } else {
            print("unable to log in \(user) with password and username")
            return
        }
    }
}
