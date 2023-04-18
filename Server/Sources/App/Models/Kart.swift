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
    
    init() { }

    init(id: UUID? = nil,
         userID: User.IDValue
         ) {
        self.id = id
        self.$user.id = userID
    }
}
