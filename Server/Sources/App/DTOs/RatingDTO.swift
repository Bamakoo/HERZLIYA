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
    let id: UUID? 
    let bookID: UUID
    let rating: Float
    let bookTitle: String?
    let username: String? 
}
