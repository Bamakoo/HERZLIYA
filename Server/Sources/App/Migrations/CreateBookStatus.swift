//
//  CreateBookStatus.swift
//  
//
//  Created by Emma Gaubert on 13/03/2023.
//

import Fluent

struct CreateBookStatus: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.enum("book_status")
            .case("available")
            .case("purchased")
            .case("inTransit")
            .case("delivered")
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.enum("book_status").delete()
    }
}
