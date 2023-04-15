//
//  File.swift
//  
//
//  Created by Emma Gaubert on 14/04/2023.
//

import Fluent
import Vapor

struct GetUser: Content {
    var id: UUID
    var username: String
    var favoriteBook: String
    var country: String
    var city: String
    var favoriteAuthor: String
}
