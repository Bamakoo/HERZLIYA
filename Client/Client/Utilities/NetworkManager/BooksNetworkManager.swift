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
    func fetchPurchasedBooks() async throws -> [GetBook] {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        print(userID)
        guard let url = URL(string: Request.baseURL + Endpoint.books + "/bought/\(userID)") else { throw HttpError.badURL }
        print(url)
        let purchasedBooks: [GetBook] = try await httpClient.fetch(url: url)
        print(purchasedBooks)
        return purchasedBooks
    }
    func fetchBooksByCategory(_ forCategory: BookGenre) async throws -> [GetBook] {
        print("I'm here")
        guard let url = URL(string: Request.baseURL + "books?genre=\(forCategory.rawValue)") else {
            throw HttpError.badURL
        }
        print(url)
        let books: [GetBook] = try await httpClient.fetch(url: url)
        return books
    }
    
    func createBook(title: String,
                    author: String,
                    description: String,
                    genre: BookGenre,
                    state: BookState,
                    status: BookStatus,
                    sellerID: String,
                    price: Int
            ) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("Unable to create valid URL for creating the book")
            return
        }
        guard let sellerID = UserDefaults.standard.string(forKey: "userID") else {
            print("unable to get the seller's ID")
            return
        }
        let newBook = CreateBookData(title: title, author: author, description: description, genre: genre, state: state, status: status, sellerID: sellerID, price: price)
        print(newBook)
        _ = try await httpClient.sendData(to: url,
                                          object: newBook,
                                          httpMethod: HttpMethods.POST.rawValue)
    }
    
    func purchaseBook(bookID: String) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("unable to generate an URL to purchase a book")
            return
        }
        guard let buyerID = UserDefaults.standard.string(forKey: "userID") else {
            print("unable to get the buyerID from userdefaults")
            return
        }
        let newBook = PatchPurchaseBook(id: bookID, buyerID: buyerID)
        print(newBook)
                try await httpClient.sendData(to: url, object: newBook, httpMethod: HttpMethods.PATCH.rawValue)
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
