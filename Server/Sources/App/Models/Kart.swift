import Fluent
import Vapor

final class Kart: Model, Content {
    static let schema = "karts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Siblings(through: KartBook.self, from: \.$kart, to: \.$book)
    public var books: [Book]
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }

    init(id: UUID? = nil,
         userID: User.IDValue,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil
         ) {
        self.id = id
        self.$user.id = userID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
