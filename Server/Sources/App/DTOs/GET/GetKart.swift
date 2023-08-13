//
//  GetKart.swift
//  
//
//  Created by Emma Gaubert on 25/04/2023.
//

import Fluent
import Vapor

struct GetKart: Content {
    let id: UUID
    let user: UUID
    let books: [GetBook]
}
