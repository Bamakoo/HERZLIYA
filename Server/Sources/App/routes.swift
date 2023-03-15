import Fluent
import Vapor

func routes(_ app: Application) throws {
//    app.grouped(UserPasswordAuthenticator())
//        .grouped(UserTokenAuthenticator())
//        .grouped(User.guardMiddleware())
//        .post("login")
//    { req in
//        let user = try req.auth.require(User.self)
//        // Do something with user.
//    }
    
    let passwordProtected = app.grouped(User.authenticator())
    passwordProtected.post("login") { req async throws -> UserToken in
        let user = try req.auth.require(User.self)
        let token = try user.generateToken()
        try await token.save(on: req.db)
        return token
    }
    try app.register(collection: UserController())
    try app.register(collection: KartController())
    try app.register(collection: BookController())
    try app.register(collection: RatingController())
    try app.register(collection: LikeController())
    try app.register(collection: CommentController())
}

