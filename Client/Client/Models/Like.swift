//
//  Like.swift
//  Client
//
//  Created by Emma Gaubert on 27/02/2023.
//

import Foundation

struct Like: Identifiable, Codable, Hashable, Equatable {
    let bookID: UUID
    let id: UUID
    let userID: UUID
    let bookTitle: String?
    let username: String?
}
