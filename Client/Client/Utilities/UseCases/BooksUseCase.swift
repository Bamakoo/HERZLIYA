//
//  BooksUseCase.swift
//  Client
//
//  Created by Emma Gaubert on 10/07/2023.
//

import Foundation

extension UseCase {
    struct Books {
        static func fetch() async throws -> [Book] {
            let books = try await API.Books.fetch()
            return books
        }

        static func likeABook(_ bookID: UUID) async throws {
            try await API.Books.likeABook(bookID)
        }

        static func fetchLikedBooks() async throws -> [Book] {
            let books = try await API.Books.fetchLikedBooks()
            return books
        }

        static func fetchBookByUsersFavoriteAuthor() async throws -> [Book] {
            let books = try await API.Books.fetchBooksByUsersFavoriteAuthor()
            return books
        }

        static func fetchSoldBooks() async throws -> [Book] {
            let books = try await API.Books.fetchSoldBooks()
            return books
        }

        static func fetchBoughtBooks() async throws -> [Book] {
            let books = try await API.Books.fetchBoughtBooks()
            return books
        }

        static func buyBook(_ bookID: UUID) async throws {
            try await API.Books.purchase(bookID)
        }

        static func sort(_ URLQueryItems: [URLQueryItem]) async throws -> [Book] {
            let books = try await API.Books.sort(URLQueryItems)
            return books
        }

        static func create(_ newBook: CreateBookData) async throws {
            try await API.Books.create(newBook)
        }
    }
}
