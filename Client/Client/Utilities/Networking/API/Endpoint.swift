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

    static func changePassword() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/change-password", queryItems: nil)
    }

    static func likedBooks() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/my/likes", queryItems: nil)
    }

    static func likes(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/likes/\(bookID)", queryItems: nil)
    }

    static func booksByUsersFavoriteAuthor() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/my/favorite-author", queryItems: nil)
    }

    static func booksInKart() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/my/kart", queryItems: nil)
    }

    static func soldBooks() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/my/sold", queryItems: nil)
    }

    static func login() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/login", queryItems: nil )
    }

    static func bought() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/my/purchases", queryItems: nil )
    }

    static func commentsOnBook(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/comments/\(bookID)", queryItems: nil)
    }

    static func myComments() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/my/comments", queryItems: nil)
    }

    static func removeBookFromCart(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/karts/remove-book/\(bookID)", queryItems: nil)
    }

    static func purchaseBook(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/\(bookID)/purchase", queryItems: nil)
    }

    static func sort(_ URLQueryItems: [URLQueryItem]) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books", queryItems: URLQueryItems)
    }

    static func addBookToKart(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/karts/add-book/\(bookID)", queryItems: nil)
    }

    static func users() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/users", queryItems: nil)
    }

    static func comments() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/comments", queryItems: nil)
    }
    
    static func deleteComment(_ commentID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/comments/\(commentID)", queryItems: nil)
    }
}
