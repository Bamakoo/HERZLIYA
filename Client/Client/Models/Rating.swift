//
//  Rating.swift
//  Client
//
//  Created by Emma Gaubert on 23/03/2023.
//

import Foundation

struct Rating: Identifiable, Codable, Hashable, Equatable {
    let id: UUID?
    let userWhoRates: UUID
    let ratedUser: UUID
    let rating: Float
}
