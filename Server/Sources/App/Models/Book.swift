import Fluent
import Vapor

enum BookGenre: String, Codable {
    case fantasy, scienceFiction, action, mystery, horror, romance, realism, biography
}

enum BookState: String, Codable {
    case horrendous, bad, okay, passable, acceptable, good, excellent, brandNew
}

enum BookStatus: String, Codable {
    case available, purchased, inTransit, delivered
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
    
    @Enum(key: "book_state")
    var state: BookState
    
    @Field(key: "price")
    var price: Int
    
    @OptionalParent(key: "order_id")
    var order: Kart?
    
    @Parent(key: "seller_id")
    var seller: User
    
    @Parent(key: "buyer_id")
    var buyer: User
    
    @Parent(key: "kart_id")
    var kart: Kart
    
    @Parent(key: "favorited_by")
    var user: User

    @Field(key: "rating")
    var rating: Float
    
    @Enum(key: "book_status")
    var status: BookStatus
    
    init() { }

    init(id: UUID? = nil,
         title: String,
         author: String,
         genre: BookGenre,
         state: BookState,
         price: Int,
         kartID: Kart.IDValue?,
         sellerID: User.IDValue,
         buyerID: User.IDValue,
         favoritedBy: User.IDValue,
         rating: Float,
         status: BookStatus) {
        self.id = id
        self.title = title
        self.author = author
        self.genre = genre
        self.state = state
        self.price = price
        self.$kart.id = kartID ?? UUID()
        self.$user.id = favoritedBy
        self.$seller.id = sellerID
        self.$buyer.id = buyerID
        self.rating = rating
        self.status = status
    }
}
