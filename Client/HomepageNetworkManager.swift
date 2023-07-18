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
    func fetchBooks() async throws -> [Book] {
        let url = URL(string: Request.baseURL + Endpoint.books)!
        let books: [Book] = try await httpClient.fetch(url: url)
        return books
    }
    
    func likeABook(_ book: Book) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.likes.rawValue) else {
            print("unable to generate an URL to like a book")
            return
        }
        guard let bookID = book.id else {
            print("unable to get the book id")
            return
        }
        let userID = "70935759-4231-43E4-8E54-92CA3A48E33B"
        let newLike = Like(userID: userID, bookID: bookID)
        _ = try await httpClient.sendData(to: url, object: newLike, httpMethod: HttpMethods.POST.rawValue)
    }
    func sort(_ sortBy: SortBy,
              _ sortAscending: Bool) async throws -> [Book] {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "127.0.0.1"
        components.port = 8080
        components.path = "/books/sort"
        components.queryItems =  [
            URLQueryItem(name: "by", value: sortBy.rawValue),
            URLQueryItem(name: "ascending", value: String(sortAscending))
        ]
        let url = components.url!
        let sortedBooks: [Book] = try await httpClient.fetch(url: url)
        return sortedBooks
    }
}
