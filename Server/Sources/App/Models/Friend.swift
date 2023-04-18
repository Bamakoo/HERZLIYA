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
    
    init() { }

    init(id: UUID? = nil,
         user: User,
         usersFriend: User
         ) throws {
        self.id = id
        self.$user.id = try user.requireID()
        self.$usersFriend.id = try usersFriend.requireID()
    }
}
