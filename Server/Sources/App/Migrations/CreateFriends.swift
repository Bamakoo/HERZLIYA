//import Fluent
//
//struct CreateFriends: AsyncMigration {
//    func prepare(on database: Database) async throws {
//        try await database.schema("friends")
//            .id()
//            .field("friend", .string, .required)
//            .field("user_id", .uuid, .references("users", "id"))
//            .create()
//    }
//    func revert(on database: Database) async throws {
//        try await database.schema("friends").delete()
//    }
//}
//
