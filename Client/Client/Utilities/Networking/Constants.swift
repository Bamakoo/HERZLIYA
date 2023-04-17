//
//  Constants.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//
import Foundation
// TODO: refactor so it's a URL Struct with nested enum 
enum Request {
    static let baseURL = "http://127.0.0.1:8080/"
}

enum Endpoint {
    static let books = "books"
    static let me = "me"
    static let users = "users"
    static let login = "login"
    static let karts = "karts"
    static let bookSearchByCategory = "search/books/by-category/"
}
