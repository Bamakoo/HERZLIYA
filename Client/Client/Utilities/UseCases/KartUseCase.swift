//
//  CartUseCase.swift
//  Client
//
//  Created by Emma Gaubert on 27/07/2023.
//

import Foundation

extension UseCase {
    struct Cart {
        static func removeBookFromCart() async throws {
            try await API.Cart.removeBookFromCart()
        }
        
        static func fetchBooksInKart() async throws -> [Book] {
            let books = try await API.Cart.fetchBooksInKart()
            return books
        }
    }
}
