import Fluent
import Vapor

final class Comment: Model, Content {
    
    static let schema = "comments"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "comment")
    var comment: String
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "book_id")
    var book: Book
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }
    
    init(id: UUID? = nil,
         comment: String,
         userID: User.IDValue,
         bookID: Book.IDValue,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil
    ) throws {
        self.id = id
        self.comment = comment
        self.$user.id = userID
        self.$book.id = bookID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
