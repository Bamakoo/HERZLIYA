import Fluent
import Vapor

final class Book: Model, Content {
    static let schema = "books"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String
    
    @Parent(key: "author_id")
    var author: Author
    
    @Field(key: "genre")
    var genre: String
    
    @Field(key: "price")
    var price: Int
    
    @Parent(key: "order_id")
    var order: Order

    init() { }

    init(id: UUID? = nil,
         title: String,
         authorID: Author.IDValue,
         genre: String,
         price: Int,
         orderID: Order.IDValue) {
        self.id = id
        self.title = title
        self.$author.id = authorID
        self.genre = genre
        self.price = price
        self.$order.id = orderID
    }
}
