//
//  ChangePasswordDTO.swift
//  Client
//
//  Created by Emma Gaubert on 06/07/2023.
//

import Foundation

struct PatchPassword: Codable {
    let id: String
    let currentPassword: String
    let confirmCurrentPassword: String
    let newPassword: String
    let confirmNewPassword: String
    let favoriteAuthor: String
    let favoriteBook: String
}
