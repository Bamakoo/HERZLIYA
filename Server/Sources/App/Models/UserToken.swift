import Fluent
import Vapor

final class UserToken: Model, Content {
    static let schema = "user_tokens"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "value")
    var value: String

    @Parent(key: "user_id")
    var user: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?

    init() { }

    init(id: UUID? = nil,
         value: String,
         userID: User.IDValue,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil) {
        self.id = id
        self.value = value
        self.$user.id = userID
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
