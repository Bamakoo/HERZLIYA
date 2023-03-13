//
//  CreateBookState.swift
//
//
//  Created by Emma Gaubert on 13/03/2023.
//

import Fluent

struct CreateBookState: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.enum("book_state")
            .case("horrendous")
            .case("bad")
            .case("okay")
            .case("passable")
            .case("acceptable")
            .case("good")
            .case("excellent")
            .case("brandNew")
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.enum("book_state").delete()
    }
}
