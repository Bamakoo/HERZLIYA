import Fluent
// TODO: use siblings for cart
struct CreateKart: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("karts")
            .id()
            .field("user_id", .uuid, .references("users", "id"))
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("karts").delete()
    }
}
