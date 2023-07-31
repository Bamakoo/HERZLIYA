import Fluent
import Vapor

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
    
    @Enum(key: "book_status")
    var status: BookStatus
    
    // TODO: turn back Comment & Like to children => one to many
    
    @Siblings(through: Comment.self, from: \.$book, to: \.$user)
    public var user: [User]
    
    @Siblings(through: Like.self, from: \.$book, to: \.$user)
    public var users: [User]
    
    @Siblings(through: KartBook.self, from: \.$book, to: \.$kart)
    public var karts: [Kart]
    
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
        self.$seller.id = sellerID
        self.$buyer.id = buyerID
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
