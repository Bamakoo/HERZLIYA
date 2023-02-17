import Fluent
import Vapor

final class Author: Model, Content {
    static let schema = "authors"
    
    @ID(key: .id)
    var id: UUID?

    @Field(key: "first_name")
    var firstName: String
    
    @Field(key: "last_name")
    var lastName: String
    
    @Children(for: \.$author)
    var books: [Book]

    init() { }

    init(id: UUID? = nil,
         firstName: String,
         lastName: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
    }
}
