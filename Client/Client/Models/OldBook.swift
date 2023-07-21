//
//  Book.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

enum BookGenre: String, Identifiable, Codable, Hashable, Equatable, CaseIterable {
    case fantasy
    case scienceFiction
    case action
    case mystery
    case horror
    case romance
    case realism
    case biography
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
        case .fantasy: return "crown.fill"
        case .scienceFiction: return "burst.fill"
        case .action: return "figure.run"
        case .mystery: return "person.fill.questionmark"
        case .horror: return "theatermasks.fill"
        case .romance: return "heart.circle.fill"
        case .realism: return "books.vertical.fill"
        case .biography: return "figure.wave"
        }
    }
}

enum BookStatus: String, Identifiable, CaseIterable, Codable {
    case available, purchased, inTransit, delivered
    var id: Self { self }
}

struct CreateBookData: Codable {
    var title: String
    var author: String
    var description: String
    var genre: BookGenre
    var state: BookState
    var status: BookStatus
    var price: Int
}
