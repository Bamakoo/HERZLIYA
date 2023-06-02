//
//  HomepageNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 31/05/2023.
//
// swiftlint:disable cyclomatic_complexity
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
    
    func sort(_ sortOrFilter: HomepageMenuSelector, _ by: HomepageSubMenuSelector ) async throws -> [GetBook] {
        var url = URL(string: Request.baseURL + Endpoint.books)!
        switch (sortOrFilter, by) {
            // MARK: display cases
        case (.display, .books):
            print(sortOrFilter.rawValue, by.rawValue)
        case (.display, .author):
            print(sortOrFilter.rawValue, by.rawValue)
        case (.display, .comments):
            print(sortOrFilter.rawValue, by.rawValue)
        case (.display, .ratings):
            print(sortOrFilter.rawValue, by.rawValue)
        case (.display, .users):
            print(sortOrFilter.rawValue, by.rawValue)
        case (.display, .title):
            print(sortOrFilter.rawValue, by.rawValue)
        case (.display, .price):
            print(sortOrFilter.rawValue, by.rawValue)
        case (.display, .state):
            print(sortOrFilter.rawValue, by.rawValue)
            // MARK: sort cases
        case (.sort, .books):
            print("hello sorted books")
        case (.sort, .comments):
            print("sort my comments")
        case (.sort, .ratings):
            print("sort by ratings")
        case(.sort, .users):
            print("sort by users")
        case (.sort, .title):
            print("sort by title")
        case (.sort, .author):
            print("sort by author")
        case (.sort, .price):
            print("sort by price")
        case (.sort, .state):
            print("sort by state")
            // MARK: filter cases
        case (.filter, .books):
            print("hello filtered books")
        case (.filter, .comments):
            print("hello filtered comments")
        case (.filter, .ratings):
            print("hello filtered ratings")
        case(.filter, .users):
            print("hello filtered users")
        case (.filter, .title):
            print("filter by title")
        case (.filter, .author):
            print("filter by author")
        case (.filter, .price):
            print("filter by price")
        case (.filter, .state):
            print("filter by state")
            print(url)
        }
        let books: [GetBook] = try await httpClient.fetch(url: url)
        return books
    }
}
