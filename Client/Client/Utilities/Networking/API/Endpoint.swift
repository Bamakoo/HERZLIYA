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

    static func likes() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/likes", queryItems: nil)
    }

    static func friends() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/friends", queryItems: nil)
    }

    static func myFriends() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/users/friends", queryItems: nil)
    }

    static func friendUser(_ userID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/friends/\(userID)", queryItems: nil)
    }

    static func book() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books", queryItems: nil)
    }

    static func specificBook(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/\(bookID)", queryItems: nil)
    }

    static func bookGenre(_ bookGenre: BookGenre) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books?genre=\(bookGenre.rawValue)", queryItems: nil)
    }

    static func search(_ searchText: String) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books?search=\(searchText)", queryItems: nil)
    }

    static func changePassword() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/change-password", queryItems: nil)
    }

    static func likedBooks() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/users/likes", queryItems: nil)
    }

    static func rating() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/ratings", queryItems: nil)
    }

    static func likeBook(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/likes/\(bookID)", queryItems: nil)
    }

    static func booksByUsersFavoriteAuthor() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/users/favorite-author", queryItems: nil)
    }

    static func booksInKart() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/users/cart", queryItems: nil)
    }

    static func soldBooks() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/users/sold", queryItems: nil)
    }

    static func login() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/login", queryItems: nil )
    }

    static func bought() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/users/purchases", queryItems: nil )
    }

    static func commentsOnBook(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/comments/\(bookID)", queryItems: nil)
    }

    static func myComments() -> APIEndpoint {
        return HerzliyaEndpoint(path: "/users/comments", queryItems: nil)
    }

    static func removeBookFromCart(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/\(bookID)/remove-from-kart", queryItems: nil)
    }

    static func purchaseBook(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/\(bookID)/purchase", queryItems: nil)
    }

    static func sort(_ URLQueryItems: [URLQueryItem]) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books", queryItems: URLQueryItems)
    }

    static func addBookToKart(_ bookID: UUID) -> APIEndpoint {
        return HerzliyaEndpoint(path: "/books/\(bookID)/add-to-kart", queryItems: nil)
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
