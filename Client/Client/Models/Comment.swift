//
//  Comment.swift
//  Client
//
//  Created by Emma Gaubert on 23/03/2023.
//

import Foundation

struct Comment: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let comment: String
    let userWhoCommented: User
    let commentedOnBook: Book
}
