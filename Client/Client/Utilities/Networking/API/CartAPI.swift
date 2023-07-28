//
//  CartAPI.swift
//  Client
//
//  Created by Emma Gaubert on 27/07/2023.
//

import Foundation

extension API {
    struct Cart {
        static func fetchBooksInKart() async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.booksInKart()).loginProtected()
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }

        static func removeBookFromCart(_ bookID: UUID) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.removeBookFromCart(bookID)).loginProtected()
            _ = try await HTTP.delete(with: request)
        }
    }
}
