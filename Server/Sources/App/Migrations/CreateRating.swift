import Fluent

struct CreateRating: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("ratings")
            .id()
            .field("user_who_rates", .uuid, .references("users", "id"))
            .field("rated_user", .uuid, .references("users", "id"))
            .field("rating", .float, .required)
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("ratings").delete()
    }
}
