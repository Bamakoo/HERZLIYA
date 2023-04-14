//
//  File.swift
//  
//
//  Created by Emma Gaubert on 12/04/2023.
//

import Foundation

struct PatchLike: Codable {
    let id: UUID
    let userID: UUID?
    let bookID: UUID?
}
