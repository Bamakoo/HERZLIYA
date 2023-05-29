//
//  Constants.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//
import Foundation

enum Request {
    static let baseURL = "http://127.0.0.1:8080/"
}

enum Endpoint: String {
    case soldBooks = "books/sold/"
    
    static let books = "books"
    static let sold = "/sold/"
    static let me = "me"
    static let users = "users"
    static let login = "login"
    static let karts = "karts"
    static let bookSearchByCategory = "search/books/by-category/"
    static let addBookToKart = "karts/add-book"
}
