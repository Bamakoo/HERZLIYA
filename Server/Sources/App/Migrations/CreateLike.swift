import Fluent

struct CreateLike: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("likes")
            .id()
            .field("user_id", .uuid, .references("users", "id"))
            .field("book_id", .uuid, .references("books", "id"))
            .unique(on: "user_id", "book_id")
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("likes").delete()
    }
}
