//
//  BooksNetworkManager.swift
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
    
    func commentOnBook(_ bookID: UUID, _ comment: String) async throws {
        guard let url = URL(string: Request.baseURL + "comments") else {
            throw HttpError.badURL
        }
        let userID = "70935759-4231-43E4-8E54-92CA3A48E33B"
        let newComment = Comment(userID: userID, bookID: bookID, comment: comment)
        _ = try await httpClient.sendData(to: url, object: newComment, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func getBooksInKart() async throws -> [Book] {
//        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        var userID = "70935759-4231-43E4-8E54-92CA3A48E33B"
        guard let url = URL(string: Request.baseURL + Endpoint.booksInKart.rawValue + userID) else {
            throw HttpError.badURL
        }
        print(url)
        let booksInUserKart: [Book] = try await httpClient.fetch(url: url)
        return booksInUserKart
    }
    
    func addBookToKart(_ bookID: UUID) async throws {
        // guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        let userID = "70935759-4231-43E4-8E54-92CA3A48E33B"
        print(userID)
        guard let url = URL(string: Request.baseURL + Endpoint.addBookToKart) else {
            throw HttpError.badURL
        }
        let kartBook = AddBookToKartDTO(userID: userID, bookID: bookID)
        _ = try await httpClient.sendData(to: url, object: kartBook, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func soldBooks() async throws -> [Book] {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        guard let url = URL(string: Request.baseURL + Endpoint.soldBooks.rawValue + userID)
        else { throw HttpError.badURL }
        let books: [Book] = try await httpClient.fetch(url: url)
        return books
    }
    
    func searchBooks(_ searchText: String) async throws -> [Book] {
        let trueSearch = searchText.replacingOccurrences(of: " ", with: "+")
        print(searchText)
        print(trueSearch)
        let stringUrl = Request.baseURL + Endpoint.books + "?title=\(trueSearch)"
        guard let url = URL(string: stringUrl)
        else {
            print("unable to create URL for searching books")
            throw HttpError.badURL
        }
        let searchResults: [Book] = try await httpClient.fetch(url: url)
        print(searchResults)
        print("working on the search bar")
        return searchResults
    }
    
    func fetchBooks() async throws -> [Book] {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let books: [Book] = try await httpClient.fetch(url: url)
        return books
    }
    
    func fetchBookByUsersFavoriteAuthor() async throws -> [Book] {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        guard let url = URL(string: Request.baseURL + Endpoint.books + "/favorite-author/\(userID)" )
        else { throw HttpError.badURL }
        let booksByUsersFavoriteAuthor: [Book] = try await httpClient.fetch(url: url)
        return booksByUsersFavoriteAuthor
    }
    
    func fetchPurchasedBooks() async throws -> [Book] {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        print(userID)
        guard let url = URL(string: Request.baseURL + Endpoint.books + "/bought/\(userID)")
        else { throw HttpError.badURL }
        print(url)
        let purchasedBooks: [Book] = try await httpClient.fetch(url: url)
        print(purchasedBooks)
        return purchasedBooks
    }
    
    func fetchBooksByCategory(_ forCategory: BookGenre) async throws -> [Book] {
        print("I'm here")
        guard let url = URL(string: Request.baseURL + "books?genre=\(forCategory.rawValue)") else {
            throw HttpError.badURL
        }
        print(url)
        let books: [Book] = try await httpClient.fetch(url: url)
        return books
    }
    
    func createBook(title: String,
                    author: String,
                    description: String,
                    genre: BookGenre,
                    state: BookState,
                    status: BookStatus,
                    price: Int
    ) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.books) else {
            print("Unable to create valid URL for creating the book")
            return
        }

        let newBook = CreateBookData(title: title, author: author,
                                     description: description, genre: genre,
                                     state: state, status: status,
                        price: price)
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
        _ = try await httpClient.sendData(to: url, object: newBook, httpMethod: HttpMethods.PATCH.rawValue)
    }
    
    func deleteBook(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.books + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}
