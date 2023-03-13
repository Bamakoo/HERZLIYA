import Fluent
import Vapor

enum BookGenre: String, Codable {
    case fantasy, scienceFiction, action, mystery, horror, romance, realism, biography
}

final class Book: Model, Content {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "author")
    var author: String
    
    @Enum(key: "book_genre")
    var genre: BookGenre
    
    @Field(key: "price")
    var price: Int
    
    @OptionalParent(key: "order_id")
    var order: Order?
    
    @Parent(key: "user_id")
    var user: User
    
    init() { }

    init(id: UUID? = nil,
         title: String,
         author: String,
         genre: BookGenre,
         price: Int,
         orderID: Order.IDValue?,
         userID: User.IDValue) {
        self.id = id
        self.title = title
        self.author = author
        self.genre = genre
        self.price = price
        self.$order.id = orderID
        self.$user.id = userID
    }
}
