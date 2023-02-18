//
//  Author.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

struct Author: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let firstName: String?
    let lastName: String?
}
