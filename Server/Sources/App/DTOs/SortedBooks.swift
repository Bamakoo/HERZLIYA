//
//  SortedBooks.swift
//  
//
//  Created by Emma Gaubert on 05/06/2023.
//

import Foundation
import Fluent
import Vapor

struct SortedBooksDTO: Content {
    let by: String?
    let ascending: Bool?
}

enum SortBy: String, Codable {
    case seller
    case title
    case state
    case price
    case genre
    case author
    case date
}
