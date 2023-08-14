//
//  BooksAPI.swift
//  Client
//
//  Created by Emma Gaubert on 10/07/2023.
//

import Foundation

extension API {
    struct Books {
        static func fetch() async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.book())
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func fetchSpecificBook(_ bookID: UUID) async throws -> Book {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.specificBook(bookID))
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let book = try decoder.decode(Book.self, from: bookData)
            return book
        }

        static func fetchBooksByGenre(_ bookGenre: BookGenre) async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.bookGenre(bookGenre))
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func search(_ searchText: String) async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.search(searchText))
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func likeABook(_ bookID: UUID) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.likes(bookID)).loginProtected()
            _ = try await HTTP.post(with: request, andBody: nil)
        }

        static func fetchLikedBooks() async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.likedBooks()).loginProtected()
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func fetchBooksByUsersFavoriteAuthor() async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.booksByUsersFavoriteAuthor()).loginProtected()
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func fetchSoldBooks() async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.soldBooks()).loginProtected()
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func fetchBoughtBooks() async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.bought()).loginProtected()
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func purchase(_ bookID: UUID) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.purchaseBook(bookID)).loginProtected()
            _ = try await HTTP.patch(with: request, andBody: nil)
        }

        static func sort(_ URLQueryItems: [URLQueryItem]) async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.sort(URLQueryItems))
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func create(_ newBook: CreateBookData) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.book()).loginProtected()
            let endoder = JSONEncoder()
            let bookData = try endoder.encode(newBook)
            _ = try await HTTP.post(with: request, andBody: bookData)
        }

        static func addBookToKart(_ bookID: UUID) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.addBookToKart(bookID)).loginProtected()
            _ = try await HTTP.post(with: request, andBody: nil)
        }
    }
}
