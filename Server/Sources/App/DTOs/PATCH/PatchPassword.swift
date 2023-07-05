//
//  File.swift
//  
//
//  Created by Emma Gaubert on 05/07/2023.
//

import Foundation

struct PatchPassword: Codable {
    let id: UUID
    let currentPassword: String
    let confirmCurrentPassword: String
    let newPassword: String
    let confirmNewPassword: String
    let favoriteAuthor: String
    let favoriteBook: String
}
