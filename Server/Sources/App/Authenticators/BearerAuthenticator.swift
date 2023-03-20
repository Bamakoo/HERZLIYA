import Vapor

struct BearerUserAuthenticator: AsyncBearerAuthenticator {
    typealias User = App.User

    func authenticate(
        bearer: BearerAuthorization,
        for request: Request
    ) async throws {
        let user = try request.content.decode(User.self)
        let userToken = try request.content.decode(UserToken.self)
        if bearer.token == userToken.value {
            request.auth.login(user)
        } else {
            print("unable to log in \(user) using Bearer")
            return
        }
   }
}
