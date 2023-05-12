import Fluent
import Vapor

final class Friend: Model, Content {
    static let schema = "friends"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    @Parent(key: "users_friend_id")
    var usersFriend: User
    
    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Timestamp(key: "deleted_at", on: .delete)
    var deletedAt: Date?
    
    init() { }

    init(id: UUID? = nil,
         user: User,
         usersFriend: User,
         createdAt: Date? = nil,
         updatedAt: Date? = nil,
         deletedAt: Date? = nil
         ) throws {
        self.id = id
        self.$user.id = try user.requireID()
        self.$usersFriend.id = try usersFriend.requireID()
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.deletedAt = deletedAt
    }
}
