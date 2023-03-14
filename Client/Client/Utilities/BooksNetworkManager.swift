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
    
    func createBook(title: String, genre: String, price: Int, author: String, order: Order) async throws {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let newBook = Book(author: author, title: title, id: UUID(), price: price, genre: genre, order: Order(id: nil, price: nil))
        print(newBook)
        try await httpClient.sendData(to: url, object: newBook, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func updateBook(author: String,  title: String, id: UUID!, price: Int, genre: String, order: Order) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("Unable to create valid URL")
            return
        }
        let updatedBook = Book(author: author, title: title, id: id,  price: price, genre: genre, order: Order(id: nil, price: nil))
        print(updatedBook)
        try await httpClient.updateData(to: url, object: updatedBook, httpMethod: HttpMethods.PUT.rawValue)
    }
    
    func deleteBook(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.books + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}