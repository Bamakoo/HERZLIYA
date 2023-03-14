import Fluent

struct CreateUser: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("users")
            .id()
            .field("username", .string, .required)
            .field("password", .string, .required)
            .field("favorite_book", .string, .required)
            .field("country", .string, .required)
            .field("city", .string, .required)
            .field("favorite_author", .string, .required)
            .field("created_at", .date)
            .field("updated_at", .date)
            .field("deleted_at", .date)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("users").delete()
    }
}
