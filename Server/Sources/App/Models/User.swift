import Fluent
import Vapor

final class User: Authenticatable, Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String
    
    @Field(key: "email")
    var email: String
    
    @Field(key: "password_hash")
    var passwordHash: String
    
    @Field(key: "favorite_book")
    var favoriteBook: String
    
    @Field(key: "country")
    var country: String
    
    @Field(key: "city")
    var city: String
    
    @Field(key: "favorite_author")
    var favoriteAuthor: String
    
    @Children(for: \.$buyer)
    var baughtBooks: [Book]
    
    @Children(for: \.$seller)
    var soldBooks: [Book]
    
    @Children(for: \.$ratedUser)
    var receivedRatings: [Rating]
    
    @Children(for: \.$userWhoRates)
    var emittedRatings: [Rating]
    
    @Children(for: \.$user)
    var likes: [Like]
    
    @Children(for: \.$userWhoCommented)
    var comments: [Comment]
    
    @Children(for: \.$user)
    var tokens: [UserToken]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    init() { }

    init(id: UUID? = nil,
         username: String,
         email: String,
         passwordHash: String,
         favoriteBook: String,
         country: String,
         city: String,
         favoriteAuthor: String,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.passwordHash = passwordHash
        self.favoriteBook = favoriteBook
        self.country = country
        self.city = city
        self.favoriteAuthor = favoriteAuthor
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
