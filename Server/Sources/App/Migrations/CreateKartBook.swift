import Fluent

struct CreateKartBook: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("kart+book")
            .id()
            .field("kart_id", .uuid, .references("karts", "id"))
            .field("book_id", .uuid, .references("books", "id"))
            .unique(on: "kart_id", "book_id")
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("likes").delete()
    }
}
