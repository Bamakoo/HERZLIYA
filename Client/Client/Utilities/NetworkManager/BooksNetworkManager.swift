//
//  SettingsNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//
// swiftlint:disable all

import Foundation

final class BooksNetworkManager {
    
    let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func fetchBooks() async throws -> [GetBook] {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let books: [GetBook] = try await httpClient.fetch(url: url)
        return books
    }
    
    func fetchBooksByCategory(_ forCategory: BookGenre?) async throws -> [GetBook] {
        guard let category = forCategory else {
            print("unable to force unwrap category")
        }
        guard let url = URL(string: Request.baseURL + Endpoint.bookSearchByCategory + "\(category)") else {
            print("unable to create url")
        }
        let books: [GetBook] = try await httpClient.fetch(url: url)
        return books
    }
    
    func createBook(id: UUID?,
                    author: String,
                    description: String,
                    genre: BookGenre,
                    state: BookState,
                    seller: User,
                    buyer: User? = nil,
                    kart: Kart? = nil,
                    status: BookStatus,
                    title: String,
                    price: Int
            ) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("Unable to create valid URL for creating the book")
            return
        }
        let newBook = Book(id: id,
                           author: author, description: description,
                           genre: genre,
                           state: state,
                           seller: seller,
                           buyer: buyer,
                           kart: kart,
                           status: status,
                           title: title,
                           price: price,
                           createdAt: nil,
                           updatedAt: nil,
                           deletedAt: nil)
        _ = try await httpClient.sendData(to: url,
                                                        object: newBook,
                                                        httpMethod: HttpMethods.POST.rawValue)
    }
    func updateBook(id: UUID, author: String, description: String, genre: BookGenre, state: BookState, seller: User, buyer: User?, status: BookStatus, title: String, price: Int) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("Unable to create valid URL for updating the book")
            return
        }
        let updatedBook = Book(id: id,
                               author: author,
                               description: description,
                               genre: genre,
                               state: state,
                               seller: seller,
                               buyer: buyer,
                               kart: nil,
                               status: status,
                               title: title,
                               price: price,
                               createdAt: nil,
                               updatedAt: nil,
                               deletedAt: nil)
        try await httpClient.sendData(to: url,
                                        object: updatedBook,
                                        httpMethod: HttpMethods.PUT.rawValue)
    }
    func deleteBook(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.books + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}
