import Fluent

struct CreateBook: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("books")
            .id()
            .field("title", .string, .required)
            .field("author", .string, .required)
            .field("genre", .string, .required)
            .field("price", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("books").delete()
    }
}
