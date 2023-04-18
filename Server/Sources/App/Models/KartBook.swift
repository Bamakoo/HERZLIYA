import Fluent
import Vapor

final class KartBook: Model, Content {
    static let schema = "kart+book"
    
    @ID(key: .id)
    var id: UUID?
    
    @Parent(key: "kart_id")
    var kart: Kart
    
    @Parent(key: "book_id")
    var book: Book
    
    init() { }

    init(id: UUID? = nil,
         kart: Kart,
         book: Book
         ) throws {
        self.id = id
        self.$kart.id = try kart.requireID()
        self.$book.id = try kart.requireID()
    }
}
