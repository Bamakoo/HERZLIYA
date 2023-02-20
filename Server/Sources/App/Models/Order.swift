import Fluent
import Vapor

final class Order: Model, Content {
    static let schema = "orders"
    
    @ID(key: .id)
    var id: UUID?
    
    @Field(key: "price")
    var price: Int
    
    @Parent(key: "buyer_id")
    var buyer: User
    
    @Parent(key: "seller_id")
    var seller: User

    
    init() { }

    init(id: UUID? = nil,
         price: Int,
         buyerID: User.IDValue,
         sellerID: User.IDValue) {
        self.id = id
        self.price = price
        self.$buyer.id = buyerID
        self.$seller.id = sellerID
    }
}
