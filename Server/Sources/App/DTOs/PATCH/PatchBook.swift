//
//  PatchBook.swift
//  
//
//  Created by Emma Gaubert on 11/04/2023.
//

import Foundation
import Vapor
import Fluent

struct PatchBook: Content {
    let id: UUID
    let title: String?
    let author: String?
    let description: String?
    let genre: BookGenre?
    let state: BookState?
    let price: Int?
    let buyerID: UUID?
    let status: BookStatus?
}
