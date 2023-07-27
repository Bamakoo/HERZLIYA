//
//  Comment.swift
//  Client
//
//  Created by Emma Gaubert on 23/03/2023.
//

import Foundation

struct Comment: Identifiable, Codable, Hashable, Equatable {
   var id: UUID? = nil
   let userID: String
   let bookID: UUID
   let comment: String
}

struct PostComment: Codable {
    var comment: String
    var bookID: UUID
}

