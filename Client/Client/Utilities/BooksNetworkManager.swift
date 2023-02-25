//
//  SettingsNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//

import Foundation

final class BooksNetworkManager {
    
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
        let newBook = Book(id: UUID(), title: title, author: author, price: price, genre: genre)
        try await httpClient.sendData(to: url, object: newBook, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func updateBook(author: String, id: UUID!, title: String, price: Int, genre: String) async throws {
        print("starting to update book")
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("Unable to create valid URL")
            return
        }
        let updatedBook = Book(id: id, title: title, author: author, price: price, genre: genre)
        print(updatedBook)
        
        try await httpClient.updateData(to: url, object: updatedBook, httpMethod: HttpMethods.PUT.rawValue)
        print("request sent")
    }
}
