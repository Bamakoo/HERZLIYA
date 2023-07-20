//
//  AddBookToKartDTO.swift
//  
//
//  Created by Emma Gaubert on 27/05/2023.
//

import Foundation
import Vapor
import Fluent

struct AddBookToKartDTO: Content {
    let bookID: UUID
}
