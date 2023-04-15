import Fluent
import Vapor

final class Friend: Model, Content {
    static let schema = "friends"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User
    
    init() { }

    init(id: UUID? = nil,
         userID: User.IDValue
         ) {
        self.id = id
        self.$user.id = userID
    }
}
