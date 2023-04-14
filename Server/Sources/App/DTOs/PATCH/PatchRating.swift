//
//  File.swift
//  
//
//  Created by Emma Gaubert on 12/04/2023.
//

import Foundation

struct PatchRating: Codable {
    let id: UUID
    let userWhoRatesID: UUID?
    let ratedUserID: UUID?
    let rating: Float?
}
