//
//  Kart.swift
//  Client
//
//  Created by Emma Gaubert on 23/03/2023.
//

import Foundation

struct Kart: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let user: User?
    let total: Int?
}
