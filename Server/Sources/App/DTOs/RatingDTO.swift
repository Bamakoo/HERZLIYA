//
//  RatingDTO.swift
//  
//
//  Created by Emma Gaubert on 10/08/2023.
//

import Foundation
import Vapor
import Fluent

struct RatingDTO: Content {
    let userWhoRates: UUID
    let ratedUser: UUID
    let rating: Float
}
