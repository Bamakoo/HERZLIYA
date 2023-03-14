import Fluent
import Vapor

final class Kart: Model, Content {
    static let schema = "karts"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "user_id")
    var user: User

    @Children(for: \.$kart)
    var books: [Book]
    
    @Field(key: "total")
    var total: Int
    
    init() { }

    init(id: UUID? = nil,
         userID: User.IDValue,
         total: Int) {
        self.id = id
        self.$user.id = userID
        self.total = total
    }
}
