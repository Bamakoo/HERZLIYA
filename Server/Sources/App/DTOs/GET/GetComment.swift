//
//  GetComment.swift
//  
//
//  Created by Emma Gaubert on 25/04/2023.
//

import Vapor
import Fluent

struct GetComment: Content {
    var id: UUID
    var comment: String
    var bookID: UUID
    var userID: UUID
}
