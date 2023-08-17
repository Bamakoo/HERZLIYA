//
//  GetLike.swift
//  
//
//  Created by Emma Gaubert on 10/08/2023.
//

import Foundation
import Vapor
import Fluent

struct GetLike: Content {
    let id: UUID
    let userID: UUID
    let bookID: UUID
    let bookTitle: String?
    let username: String?
}

