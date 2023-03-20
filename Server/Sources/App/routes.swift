import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    app.post("users") { req async throws -> User in
        try User.Create.validate(content: req)
        let newUser = try req.content.decode(User.Create.self)
        guard newUser.password == newUser.confirmPassword else {
            throw Abort(.badRequest, reason: "Passwords did not match")
        }
        let user = try User(
            username: newUser.username,
            email: newUser.email,
            passwordHash: Bcrypt.hash(newUser.password),
            favoriteBook: newUser.favoriteBook,
            country: newUser.country,
            city: newUser.city
        )
        try await user.save(on: req.db)
        return user
    }
    
    let passwordProtected = app.grouped(User.authenticator())
    passwordProtected.post("login") { req async throws -> UserToken in
        let user = try req.auth.require(User.self)
        let token = try user.generateToken()
        try await token.save(on: req.db)
        return token
    }
    
    let tokenProtected = app.grouped(UserToken.authenticator())
    tokenProtected.get("me") { req -> User in
        try req.auth.require(User.self)
    }
    try app.register(collection: UserController())
    try app.register(collection: KartController())
    try app.register(collection: BookController())
    try app.register(collection: RatingController())
    try app.register(collection: LikeController())
    try app.register(collection: CommentController())
}

