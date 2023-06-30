//
//  HomepageNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 31/05/2023.
//
import Foundation

final class HomepageNetworkManager {
    let httpClient: HttpClient
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    func fetchBooks() async throws -> [GetBook] {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let books: [GetBook] = try await httpClient.fetch(url: url)
        return books
    }
    func sort(_ sortBy: SortBy,
              _ sortAscending: Bool) async throws -> [GetBook] {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8080
        components.path = "/books/sort"
        components.queryItems =  [
            URLQueryItem(name: "by", value: sortBy.rawValue),
            URLQueryItem(name: "ascending", value: String(sortAscending))
        ]
        let url = components.url!
        let sortedBooks: [GetBook] = try await httpClient.fetch(url: url)
        return sortedBooks
    }
}
