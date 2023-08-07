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
    /// Used to filter URL parameters 
    struct QueryFilter: Content {
        let search: String?
        let by: String?
        let ascending: Bool?
        let genre: BookGenre?
        let state: BookState?
        
        let title: String?
        let author: String?
        let price: Int?
    }
}
