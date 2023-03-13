import Fluent

struct CreateBook: AsyncMigration {
    func prepare(on database: Database) async throws {
        let bookGenre = try await database.enum("book_genre").read()
        let bookState = try await database.enum("book_state").read()
        
        try await database.schema("books")
            .id()
            .field("title", .string, .required)
            .field("author", .string, .required)
            .field("book_genre", bookGenre, .required)
            .field("book_state", bookState, .required)
            .field("price", .int, .required)
            .field("order_id", .uuid, .references("orders", "id"))
            .field("seller_id", .uuid, .references("users", "id"))
            .field("rating", .float, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("books").delete()
    }
}
