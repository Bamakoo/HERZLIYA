//
//  Order.swift
//  Client
//
//  Created by Emma Gaubert on 27/02/2023.
//

import Foundation

struct Order: Identifiable, Codable, Hashable, Equatable {
    let id: UUID
//    let buyer: User
//    let seller: User
    let price: Int
}
