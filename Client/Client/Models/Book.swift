//
//  Book.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

enum BookGenre: String, Identifiable, Codable, Hashable, Equatable, CaseIterable {
    case fantasy, scienceFiction, action, mystery, horror, romance, realism, biography
    var id: Self { self }
    var title: String {
        switch self {
        case .fantasy: return "Fantasy"
        case .scienceFiction: return "Science Fiction"
        case .action: return "Action"
        case .mystery: return "Mystery"
        case .horror: return "Horror"
        case .romance: return "Romance"
        case .realism: return "Realism"
        case .biography: return "Biography"
        }
    }
    var image: String {
        switch self {
        case .fantasy: return "tree.fill"
        case .scienceFiction: return "burst.fill"
        case .action: return "suitcase.fill"
        case .mystery: return "dice.fill"
        case .horror: return "theatermasks.fill"
        case .romance: return "heart.circle.fill"
        case .realism: return "books.vertical.fill"
        case .biography: return "books.vertical.circle"
        }
    }
}

enum BookState: String, Identifiable, CaseIterable, Codable {
    case horrendous, bad, okay, passable, acceptable, good, excellent, brandNew
    var id: Self { self }
}

enum BookStatus: String, Identifiable, CaseIterable, Codable {
    case available, purchased, inTransit, delivered
    var id: Self { self }
}

struct Book: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let author: String
    let description: String
    let genre: BookGenre
    let state: BookState
    let seller: User
    let buyer: User?
    let kart: Kart?
    let status: BookStatus
    let title: String
    let price: Int
    let createdAt: Date?
    let updatedAt: Date?
    let deletedAt: Date?
}
