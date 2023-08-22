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
    let id: UUID
    let descritpion: String
    let genre: BookGenre
    let rating: Float?
    let title: String
    let author: String
    let price: Int
    let state: BookState
}
