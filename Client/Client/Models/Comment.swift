//
//  Comment.swift
//  Client
//
//  Created by Emma Gaubert on 23/03/2023.
//

import Foundation

struct Comment: Identifiable, Codable, Hashable, Equatable {
    let id: UUID
    let userID: String
    let bookID: UUID
    let comment: String
    let username: String?
    let bookTitle: String?
}

struct PostComment: Codable {
    let comment: String
    let bookID: UUID
}
