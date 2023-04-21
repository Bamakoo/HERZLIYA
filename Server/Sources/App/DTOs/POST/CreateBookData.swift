//
//  CreateBookData.swift
//  
//
//  Created by Emma Gaubert on 21/04/2023.
//

import Foundation
import Vapor
import Fluent

struct CreateBookData: Content {
    var title: String
    var author: String
    var description: String
    var genre: BookGenre
    var state: BookState
    var status: BookStatus
    var sellerID: UUID
    var buyerID: UUID? = nil
    var price: Int
}

