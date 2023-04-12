//
//  PatchUser.swift
//  Server
//
//  Created by Emma Gaubert on 12/04/2023.
//

import Foundation

struct PatchUser: Codable {
    let id: UUID
    let username: String?
    let email: String?
    let favoriteBook: String?
    let country: String?
    let city: String?
    let favoriteAuthor: String?
}
