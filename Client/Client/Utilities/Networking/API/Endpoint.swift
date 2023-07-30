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

    static func soldBooks() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/sold", queryItems: nil)
    }

    static func login() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/login", queryItems: nil )
    }

    static func bought() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/bought", queryItems: nil )
    }

    static func commentsOnBook(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/comments/\(bookID)", queryItems: nil)
    }

    static func myComments() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/comments/users", queryItems: nil)
    }

    static func removeBookFromCart(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/karts/remove-book/\(bookID)", queryItems: nil)
    }

    static func purchaseBook(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/purchase/\(bookID)", queryItems: nil)
    }

    static func sort(_ URLQueryItems: [URLQueryItem]) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/sort", queryItems: URLQueryItems)
    }
}
