//
//  Book.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

struct Book: Identifiable, Codable, Hashable, Equatable {
    var id: UUID?
    var title: String?
    var authorID: UUID?
    var orderID: UUID?
    var genre: String?
    var price: Int?
}
