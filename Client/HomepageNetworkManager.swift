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
    func sortFilterHandler(_ sortOrFilter: HomepageMenuSelector, _ sortOrFilterBy: HomepageSubMenuSelector ) async throws -> [GetBook] {
        var url = URL(string: Request.baseURL)
        switch sortOrFilter {
        case .filter :
            
        case .sort :
        default :
        }
    }
}
