//
//  File.swift
//  
//
//  Created by Emma Gaubert on 12/04/2023.
//

// TODO: LAURE & MICHAEL ASK about relationships in my SQL Table
// Best practices when performing patch operations with URI

import Foundation

struct PatchKart: Codable {
    let id: UUID
    let userID: UUID?
    let total: Int?
}
