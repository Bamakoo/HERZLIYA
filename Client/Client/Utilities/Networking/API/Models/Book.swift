//
//  Book.swift
//  Client
//
//  Created by Emma Gaubert on 10/07/2023.
//

import Foundation

enum BookState: String, Identifiable, CaseIterable, Codable {
    case horrendous
    case bad
    case okay
    case passable
    case acceptable
    case good
    case excellent
    case brandNew
    var id: Self { self }
}

struct Book: Identifiable, Codable, Hashable, Equatable {
    var id: UUID?
    var title: String
    var author: String
    var price: Int
    var state: BookState
}
