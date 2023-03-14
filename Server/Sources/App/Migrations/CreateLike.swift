import Fluent

struct CreateLike: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("likes")
            .id()
            .field("user", .uuid, .references("users", "id"))
            .field("liked_book", .uuid, .references("books", "id"))
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("likes").delete()
    }
}
