//
//  GetKart.swift
//  
//
//  Created by Emma Gaubert on 25/04/2023.
//

import Fluent
import Vapor

struct GetKart: Content {
    var id: UUID
    var user: UUID
    var books: [GetBook]
}
