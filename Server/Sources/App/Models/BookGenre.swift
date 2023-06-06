//
//  BookGenre.swift
//  
//
//  Created by Emma Gaubert on 19/05/2023.
//

import Foundation
import Fluent
import Vapor

enum BookGenre: String, Content, Codable, CaseIterable {
    case fantasy
    case scienceFiction
    case action
    case mystery
    case horror
    case romance
    case realism
    case biography
}
