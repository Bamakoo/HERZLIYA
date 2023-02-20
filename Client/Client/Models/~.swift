//
//  Order.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import Foundation

struct Order: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let price: Int
    let buyer: User
    let seller: User
    let books: [Book]

}
