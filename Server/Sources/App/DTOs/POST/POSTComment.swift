//
//  POSTComment.swift
//  Server
//
//  Created by Emma Gaubert on 25/04/2023.
//

import Foundation
import Fluent
import Vapor

struct PostComment: Content {
    var comment: String
    var bookID: UUID
    var userID: UUID
}
