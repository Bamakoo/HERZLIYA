//
//  Element.swift
//  
//
//  Created by Emma Gaubert on 18/08/2023.
//

import Fluent
import Vapor
import Foundation

enum ElementType: Content {
    case comment(GetComment)
    case rating(RatingDTO)
    case book(GetBook)
    case user(GetUser)
    case like(GetLike)
}

struct Element: Content {
    let type: ElementType
}
