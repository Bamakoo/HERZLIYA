//
//  Like.swift
//  Client
//
//  Created by Emma Gaubert on 27/02/2023.
//

import Foundation

struct Like: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let user: User
    let likedBook: Book
}
