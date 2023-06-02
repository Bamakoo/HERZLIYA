//
//  HomepageMenuSelector.swift
//  Client
//
//  Created by Emma Gaubert on 31/05/2023.
//

import Foundation

enum HomepageMenuSelector: String {
    case display = "Display"
    case sort = "Sort by"
    case filter = "Filter by"
}

enum HomepageSubMenuSelector: String {
    case books = "Books"
    case comments = "Comments"
    case ratings = "Ratings"
    case users = "Users"
    
    case title = "Title"
    case author = "Author"
    case price = "Price"
    case state = "State"
}
