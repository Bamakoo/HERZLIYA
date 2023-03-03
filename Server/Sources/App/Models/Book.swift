import Fluent
import Vapor

final class Book: Model, Content {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Field(key: "author")
    var author: String
    
    @Field(key: "genre")
    var genre: String
    
    @Field(key: "price")
    var price: Int
    
    @OptionalParent(key: "order_id")
    var order: Order?

    init() { }

    init(id: UUID? = nil,
         title: String,
         author: String,
         genre: String,
         price: Int,
         orderID: Order.IDValue?) {
        self.id = id
        self.title = title
        self.author = author
        self.genre = genre
        self.price = price
        if let orderID {
            self.$order.id = orderID
        }
    }
}
