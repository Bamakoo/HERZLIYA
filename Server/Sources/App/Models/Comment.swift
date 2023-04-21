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
    
    init() { }
    
    init(id: UUID? = nil,
         comment: String,
         user: User,
         book: Book
    ) throws {
        self.id = id
        self.comment = comment
        self.$user.id = try user.requireID()
        self.$book.id = try book.requireID()
    }
}
