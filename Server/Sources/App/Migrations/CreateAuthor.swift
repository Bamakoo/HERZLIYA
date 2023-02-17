import Fluent

struct CreateAuthor: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("authors")
            .id()
            .field("first_name", .string, .required)
            .field("last_name", .string, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("authors").delete()
    }
}
