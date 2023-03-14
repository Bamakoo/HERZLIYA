import Fluent

struct CreateComment: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("comments")
            .id()
            .field("comment", .string, .required)
            .field("user_id", .uuid, .references("users", "id"))
            .field("book_id", .uuid, .references("books", "id"))
            .create()
    }
    
    func revert(on database: Database) async throws {
        try await database.schema("comments").delete()
    }
}
