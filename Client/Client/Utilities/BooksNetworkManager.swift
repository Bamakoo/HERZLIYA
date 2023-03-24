//
//  SettingsNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//

import Foundation

final class BooksNetworkManager {
    let httpClient: HttpClient
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    func fetchBooks() async throws -> [Book] {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let books: [Book] = try await httpClient.fetch(url: url)
        return books
    }
    func createBook(title: String, genre: String, price: Int, author: String, kart: nil) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("Unable to create valid URL for creating the book")
            return
        }
        let newBook = Book(author: author, title: title, id: UUID(), price: price, genre: genre, order: Order(id: nil, price: nil))
        try await httpClient.sendData(to: url, object: newBook, httpMethod: HttpMethods.POST.rawValue)
    }
    func updateBook(author: String, title: String, id: UUID!, price: Int, genre: String, order: Order) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("Unable to create valid URL for updating the book")
            return
        }
        let updatedBook = Book(id: nil, author: <#T##String#>, description: <#T##String#>, genre: <#T##BookGenre#>, state: <#T##BookState#>, seller: <#T##User#>, buyer: <#T##User?#>, kart: nil, status: <#T##BookStatus#>, title: <#T##String#>, price: <#T##Int#>, createdAt: nil, updatedAt: nil, deletedAt: nil)
        try await httpClient.updateData(to: url, object: updatedBook, httpMethod: HttpMethods.PUT.rawValue)
    }
    func deleteBook(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.books + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}
