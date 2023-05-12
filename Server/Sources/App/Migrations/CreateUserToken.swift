import Fluent

struct CreateUserToken: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("user_tokens")
            .id()
            .field("value", .string, .required)
            .field("user_id", .uuid, .references("users", "id"))
            .field("created_at", .date)
            .field("updated_at", .date)
            .field("deleted_at", .date)
            .unique(on: "value")
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("user_tokens").delete()
    }
}

