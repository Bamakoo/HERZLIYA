//
//  BookQueryFilter.swift
//  
//
//  Created by Emma Gaubert on 19/04/2023.
//

import Fluent
import Foundation
import Vapor

extension Book {
    struct QueryFilter: Content {
        let genre: BookGenre?
        let state: BookState?
        let title: String?
        let author: String?
        let price: Int?
    }
}
