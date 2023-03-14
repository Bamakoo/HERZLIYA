import Fluent
import Vapor

final class Comment: Model, Content {
    
    static let schema = "comments"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "comment")
    var comment: String
    
    @Parent(key: "user_id")
    var userWhoCommented: User
    
    @Parent(key: "book_id")
    var commentedOnBook: Book
    
    init() { }

    init(id: UUID? = nil,
         comment: String,
         userWhoCommentedID: User.IDValue,
         commentedOnBookID: Book.IDValue
        ) {
        self.id = id
        self.comment = comment
        self.$userWhoCommented.id = userWhoCommentedID
        self.$commentedOnBook.id = commentedOnBookID
    }
}
