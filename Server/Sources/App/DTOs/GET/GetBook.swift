//
//  GetBook.swift
//  
//
//  Created by Emma Gaubert on 14/04/2023.
//

import Fluent
import Vapor
// Structure of GET /books response.
struct GetBook: Content {
    var id: UUID
    var title: String
    var author: String
    var price: Int
}
