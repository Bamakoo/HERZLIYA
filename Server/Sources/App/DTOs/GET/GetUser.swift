//
//  File.swift
//  
//
//  Created by Emma Gaubert on 14/04/2023.
//

import Fluent
import Vapor

struct GetUser: Content {
    let id: UUID
    let username: String
    let favoriteBook: String
    let country: String
    let city: String
    let favoriteAuthor: String
}
