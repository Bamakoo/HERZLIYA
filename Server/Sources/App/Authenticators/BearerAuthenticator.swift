import Vapor

struct BearerUserAuthenticator: AsyncBearerAuthenticator {
    typealias User = App.User

    func authenticate(
        bearer: BearerAuthorization,
        for request: Request
    ) async throws {
        let userToken = try request.content.decode(UserToken.self)
        if bearer.token == userToken.value {
            request.auth.login(User())
       }
   }
}
