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
    
    @Parent(key: "seller_id")
    var seller: User
    
    @Parent(key: "buyer_id")
    var buyer: User
    
    @Parent(key: "kart_id")
    var kart: Kart
    
    @Parent(key: "liked_by")
    var likedByUser: User

    @Field(key: "rating")
    var rating: Float
    
    @Enum(key: "book_status")
    var status: BookStatus
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }

    init(id: UUID? = nil,
         title: String,
         author: String,
         genre: BookGenre,
         state: BookState,
         price: Int,
         sellerID: User.IDValue,
         buyerID: User.IDValue,
         kartID: Kart.IDValue?,
         likedByUser: User.IDValue,
         rating: Float,
         status: BookStatus,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.genre = genre
        self.state = state
        self.price = price
        self.$kart.id = kartID ?? UUID()
        self.$likedByUser.id = likedByUser
        self.$seller.id = sellerID
        self.$buyer.id = buyerID
        self.rating = rating
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
