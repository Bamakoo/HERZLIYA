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
    case likes = "likes"
    case soldBooks = "books/sold/"
    case booksInKart = "books/kart/"
    case sortBooks = "books/sort?"
    static let books = "books"
    static let sold = "/sold/"
    static let myself = "me"
    static let users = "users"
    static let login = "login"
    static let karts = "karts"
    static let bookSearchByCategory = "search/books/by-category/"
    static let addBookToKart = "karts/add-book"
}
