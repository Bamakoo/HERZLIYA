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
        
        static func fetchLikedBooks() async throws -> [Book] {
            let books = try await API.Books.fetchLikedBooks()
            return books
        }
        
        static func fetchBookByUsersFavoriteAuthor() async throws -> [Book] {
            let books = try await API.Books.fetchBooksByUsersFavoriteAuthor()
            return books
        }
    }
}
