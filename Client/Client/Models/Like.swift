//
//  Like.swift
//  Client
//
//  Created by Emma Gaubert on 27/02/2023.
//

import Foundation

struct Like: Codable, Hashable, Equatable {
    let userID: String
    let bookID: UUID
}
