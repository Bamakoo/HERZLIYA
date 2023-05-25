//
//  GetUser.swift
//  Client
//
//  Created by Emma Gaubert on 16/05/2023.
//

import Foundation

struct GetUser: Codable {
    var id: UUID
    var username: String
    var favoriteBook: String
    var country: String
    var city: String
    var favoriteAuthor: String
}
