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
    let bookID: UUID
    let rating: Float
}
