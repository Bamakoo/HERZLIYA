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
        let newComment = PostComment(comment: comment, bookID: bookID)
        _ = try await httpClient.sendData(to: url, object: newComment, httpMethod: HttpMethods.POST.rawValue)
    }

    func addBookToKart(_ bookID: UUID) async throws {
        // guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        _ = "70935759-4231-43E4-8E54-92CA3A48E33B"
        guard let url = URL(string: Request.baseURL + Endpoint.addBookToKart) else {
            throw HttpError.badURL
        }
        let kartBook = AddBookToKartDTO(bookID: bookID)
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
        let stringUrl = Request.baseURL + Endpoint.books + "?search=\(trueSearch)"
        guard let url = URL(string: stringUrl)
        else {
            throw HttpError.badURL
        }
        let searchResults: [Book] = try await httpClient.fetch(url: url)
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
        guard let url = URL(string: Request.baseURL + Endpoint.books + "/bought/\(userID)")
        else { throw HttpError.badURL }
        let purchasedBooks: [Book] = try await httpClient.fetch(url: url)
        return purchasedBooks
    }

    func fetchBooksByCategory(_ forCategory: BookGenre) async throws -> [Book] {

        guard let url = URL(string: Request.baseURL + "books?genre=\(forCategory.rawValue)") else {
            throw HttpError.badURL
        }
        let books: [Book] = try await httpClient.fetch(url: url)
        return books
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
