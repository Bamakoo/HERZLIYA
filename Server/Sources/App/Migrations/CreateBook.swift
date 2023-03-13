import Fluent

struct CreateBook: AsyncMigration {
    func prepare(on database: Database) async throws {
        let bookGenre = try await database.enum("book_genre").read()
        
        try await database.schema("books")
            .id()
            .field("title", .string, .required)
            .field("author", .string, .required)
            .field("genre", bookGenre, .required)
            .field("price", .int, .required)
            .field("order_id", .uuid, .references("orders", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("books").delete()
    }
}
