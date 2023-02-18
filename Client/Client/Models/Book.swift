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
    let authorID: UUID?
    let orderID: UUID?
    let genre: String?
    let price: Int?
}
