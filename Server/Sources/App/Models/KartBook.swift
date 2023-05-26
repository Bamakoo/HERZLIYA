import Fluent
import Vapor

final class KartBook: Model, Content {
    static let schema = "kart+book"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "kart_id")
    var kart: Kart
    
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
         kartID: Kart.IDValue,
         bookID: Book.IDValue,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil
         ) {
        self.id = id
        self.$kart.id = kartID
        self.$book.id = bookID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
