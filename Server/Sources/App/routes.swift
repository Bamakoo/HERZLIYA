import Fluent
import Vapor

func routes(_ app: Application) throws {
    
    try app.register(collection: LoginController())
    
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

