import Fluent
import Vapor

final class User: Model, Content {
    static let schema = "users"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "username")
    var username: String
    
    @Field(key: "password")
    var password: String
    
    @Children(for: \.$buyer)
    var buyerOrders: [Order]
    
    @Children(for: \.$seller)
    var sellerOrders: [Order]


    init() { }

    init(id: UUID? = nil,
         username: String,
         password: String) {
        self.id = id
        self.username = username
        self.password = password
    }
}
