//
//  GetComment.swift
//  
//
//  Created by Emma Gaubert on 25/04/2023.
//

import Vapor
import Fluent

struct GetComment: Content {
    let id: UUID
    let comment: String
    let bookID: UUID
    let userID: UUID
    let username: String?
    let bookTitle: String?
}
