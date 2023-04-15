import Fluent
import Vapor
// TODO: check all relationships SQL
// TODO: test all endpoints
enum BookGenre: String, Codable {
    case fantasy
    case scienceFiction
    case action
    case mystery
    case horror
    case romance
    case realism
    case biography
}

enum BookState: String, Codable {
    case horrendous
    case bad
    case okay
    case passable
    case acceptable
    case good
    case excellent
    case brandNew
}

enum BookStatus: String, Codable {
    case available
    case purchased
    case inTransit
    case delivered
}

final class Book: Model, Content {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "title")
    var title: String
    
    @Field(key: "author")
    var author: String
    
    @Field(key: "description")
    var description: String
    
    @Enum(key: "book_genre")
    var genre: BookGenre
    
    @Enum(key: "book_state")
    var state: BookState
    
    @Field(key: "price")
    var price: Int
    
    @Parent(key: "seller_id")
    var seller: User
    
    @OptionalParent(key: "buyer_id")
    var buyer: User?
    
    @OptionalParent(key: "kart_id")
    var kart: Kart?
    
    @Enum(key: "book_status")
    var status: BookStatus
    
    @Children(for: \.$commentedOnBook)
    var commentsOnBooks: [Comment]
    
    @Children(for: \.$likedBook)
    var likes: [Like]
    
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
         description: String,
         genre: BookGenre,
         state: BookState,
         price: Int,
         sellerID: User.IDValue,
         buyerID: User.IDValue?,
         kartID: Kart.IDValue?,
         status: BookStatus,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) {
        self.id = id
        self.title = title
        self.author = author
        self.description = description
        self.genre = genre
        self.state = state
        self.price = price
        self.$kart.id = kartID ?? UUID()
        self.$seller.id = sellerID
        self.$buyer.id = buyerID
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
