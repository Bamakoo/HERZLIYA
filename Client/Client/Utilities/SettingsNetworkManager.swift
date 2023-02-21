//
//  SettingsNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//

import Foundation

final class SettingNetworkManager {
    
    let httpClient: HttpClient
    
    init(httpClient: HttpClient){
        self.httpClient = httpClient
    }
    
    func fetchBooks() async throws -> [Book] {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let books: [Book] = try await httpClient.fetch(url: url)
        return books
    }
    
    func createBook(title: String, genre: String, price: Int, author: String) async throws {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let newBook = Book(id: nil, title: title, author: author, genre: genre, price: price)
        try await httpClient.sendData(to: url, object: newBook, httpMethod: HttpMethods.POST.rawValue)
    }
}
