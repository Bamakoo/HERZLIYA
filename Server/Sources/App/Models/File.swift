import Fluent
import Vapor

extension User {
    struct Create: Content {
        var username: String
        var email: String
        var password: String
        var confirmPassword: String 
        var favoriteBook: String
        var country: String
        var city: String
        var favoriteAuthor: String
        var createdAt: Date?
        var updatedAt: Date?
        var deletedAt: Date?
    }
}
