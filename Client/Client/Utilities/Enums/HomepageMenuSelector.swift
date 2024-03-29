//
//  HomepageMenuSelector.swift
//  Client
//
//  Created by Emma Gaubert on 31/05/2023.
//

import Foundation

enum WhatToDisplay: String {
    case books = "Books"
    case comments = "Comments"
    case ratings = "Ratings"
    case users = "Users"
}

enum SortOrFilter: String {
    case sort = "Sort"
    case filter = "Filter"
}

enum Filters {
    case username(String)
    case state(BookState)
    case title(String)
    case price(Int)
    case genre(BookGenre)
}

enum SortBy: String {
    case seller
    case title
    case state
    case price
    case genre
    case author
    case date
}

enum AscendingOrDescending: String {
    case ascending = "Ascending"
    case descending = "Descending"
}

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
