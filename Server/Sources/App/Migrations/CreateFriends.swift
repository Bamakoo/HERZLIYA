import Fluent

struct CreateFriends: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("friends")
            .id()
            .field("user_id", .uuid, .references("users", "id"))
            .field("users_friend_id", .uuid, .references("users", "id"))
            .unique(on: "user_id", "users_friend_id")
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.schema("friends").delete()
    }
}

