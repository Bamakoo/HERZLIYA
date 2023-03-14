import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: UserController())
    try app.register(collection: KartController())
    try app.register(collection: BookController())
    try app.register(collection: RatingController())
    try app.register(collection: LikeController())
}
