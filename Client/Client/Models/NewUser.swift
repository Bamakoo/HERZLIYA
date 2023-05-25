//
//  NewUser.swift
//  Client
//
//  Created by Emma Gaubert on 15/05/2023.
//

import Foundation

struct NewUser: Codable {
    let username: String
    let email: String
    let password: String
    let confirmPassword: String
    let favoriteBook: String
    let favoriteAuthor: String
    let city: String
    let country: String
}
