//
//  Book.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

enum BookGenre: String, Codable {
    case fantasy, scienceFiction, action, mystery, horror, romance, realism, biography
}

enum BookState: String, Codable {
    case horrendous, bad, okay, passable, acceptable, good, excellent, brandNew
}

enum BookStatus: String, Codable {
    case available, purchased, inTransit, delivered
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

