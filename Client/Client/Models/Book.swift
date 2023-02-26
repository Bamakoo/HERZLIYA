//
//  Book.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

struct Book: Identifiable, Codable, Hashable, Equatable {
    let author: String
    let title: String
    let id: UUID
    let price: Int
    let genre: String
}
