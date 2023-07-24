//
//  Endpoint.swift
//  Client
//
//  Created by Emma Gaubert on 05/07/2023.
//

import Foundation

protocol APIEndpoint {
    var url: URL? { get }
}

struct HerzliyaEndpoint: APIEndpoint {
    let path: String
    let queryItems: [URLQueryItem]?
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "127.0.0.1"
        urlComponents.port = 8080
        urlComponents.path = path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
}

struct NewEndpoint {
    static func book() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books", queryItems: nil)
    }
    static func likedBooks() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/likes", queryItems: nil)
    }
    
    static func booksByUsersFavoriteAuthor() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/favorite-author", queryItems: nil)
    }
    
    static func booksInKart() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/kart", queryItems: nil)
    }
}
