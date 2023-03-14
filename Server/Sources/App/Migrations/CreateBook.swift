import Fluent

struct CreateBook: AsyncMigration {
    func prepare(on database: Database) async throws {
        
        let bookGenre = try await database.enum("book_genre").read()
        let bookState = try await database.enum("book_state").read()
        let bookStatus = try await database.enum("book_status").read()
        
        try await database.schema("books")
            .id()
            .field("title", .string, .required)
            .field("author", .string, .required)
            .field("book_genre", bookGenre, .required)
            .field("book_state", bookState, .required)
            .field("price", .int, .required)
            .field("seller_id", .uuid, .references("users", "id"))
            .field("buyer_id", .uuid, .references("users", "id"))
            .field("kart_id", .uuid, .references("karts", "id"))
            .field("liked_by", .uuid, .references("users", "id"))
            .field("rating", .float, .required)
            .field("book_status", bookStatus, .required)
            .field("created_at", .date)
            .field("updated_at", .date)
            .field("deleted_at", .date)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("books").delete()
    }
}
