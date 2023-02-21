//
//  Book.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

struct Book: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let title: String?
    let author: String?
    let genre: String?
    let price: Int?
//    var isFavorite: Bool
}
