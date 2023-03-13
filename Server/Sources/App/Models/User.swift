import Fluent
import Vapor

final class User: Authenticatable, Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "favorite_book")
    var favoriteBook: String
    
    @Field(key: "country")
    var country: String
    
    @Field(key: "city")
    var city: String
    
    @Children(for: \.$user)
    var favoritedBooks: [Book]
    
    @Field(key: "favorite_author")
    var favoriteAuthor: String
    
    @Children(for: \.$buyer)
    var baughtBooks: [Book]
    
    @Children(for: \.$seller)
    var soldBooks: [Book]

    init() { }

    init(id: UUID? = nil,
         username: String,
         password: String,
         favoriteBook: String,
         favoriteAuthor: String) {
        self.id = id
        self.username = username
        self.password = password
        self.favoriteBook = favoriteBook
        self.favoriteAuthor = favoriteAuthor
    }
}
