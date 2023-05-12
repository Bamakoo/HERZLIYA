import Fluent

struct CreateKart: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("karts")
            .id()
            .field("user_id", .uuid, .references("users", "id"))
            .field("created_at", .date)
            .field("updated_at", .date)
            .field("deleted_at", .date)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("karts").delete()
    }
}
