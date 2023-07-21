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
        
        static func fetchLikedBooks() async throws -> [Book] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.likedBooks()).loginProtected()
            let bookData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let books = try decoder.decode([Book].self, from: bookData)
            return books
        }
    }
}
