//
//  CreateBookGenre.swift
//  
//
//  Created by Emma Gaubert on 13/03/2023.
//

import Fluent

struct CreateBookGenre: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.enum("book_genre")
            .case("fantasy")
            .case("science_fiction")
            .case("action")
            .case("mystery")
            .case("horror")
            .case("romance")
            .case("realism")
            .case("biography")
            .create()
    }
    func revert(on database: Database) async throws {
        try await database.enum("book_genre").delete()
    }
}
