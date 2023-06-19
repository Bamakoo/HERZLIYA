//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation
@MainActor
final class BooksViewModel: ObservableObject {
    @Published var title = ""
    @Published var author = ""
    @Published var description = ""
    @Published var genre: BookGenre = .action
    @Published var state: BookState = .acceptable
    @Published var price = 0
    @Published var status: BookStatus = .available
    @Published var books = [GetBook]()
    @Published var purchasedBooks = [GetBook]()
    @Published var kartBooks = [GetBook]()
    @Published var booksByUsersFavoriteAuthor = [GetBook]()
    @Published var searchText: String = ""
    @Published var searchResults = [GetBook]()
    @Published var soldBooks = [GetBook]()

    private let networkManager: BooksNetworkManager
    init(networkManager: BooksNetworkManager) {
        self.networkManager = networkManager
    }
    func getBooksInKart() async throws {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        let token = try Keychain.search()
        print(token)
        print(userID)
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/books/kart/\(userID)")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
               do {
                  let books = try JSONDecoder().decode([GetBook].self, from: data)
                   DispatchQueue.main.async {
                       self.kartBooks.append(contentsOf: books)
                   }
               } catch let error {
                   print(error.localizedDescription)
               }
            }
        }
        task.resume()
    }
    func addBookToKart(_ bookID: UUID) async {
        do {
            try await networkManager.addBookToKart(bookID)
        } catch {
            print(error.localizedDescription)
        }
    }
    func search() async {
        do {
            print(searchText)
            guard !searchText.isEmpty else { return }
            print(searchText)
            print(searchText.isEmpty)
            searchResults = try await networkManager.searchBooks(searchText)
            print(searchResults)
        } catch {
            print(error.localizedDescription)
        }
    }
    func fetchBooks() async {
        do {
            books = try await networkManager.fetchBooks()
        } catch {
            print("unable to fetch books because of : \(error.localizedDescription)")
        }
    }
    func bookByUsersFavoriteAuthor() async throws {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        let token = try Keychain.search()
        print(token)
        print(userID)
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/books/favorite-author/\(userID)")!,timeoutInterval: Double.infinity)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
               do {
                  let books = try JSONDecoder().decode([GetBook].self, from: data)
                   DispatchQueue.main.async {
                       self.booksByUsersFavoriteAuthor.append(contentsOf: books)
                   }
               } catch let error {
                   print(error.localizedDescription)
               }
            }
        }
        task.resume()
    }
    func soldBooks() async throws {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        let token = try Keychain.search()
        print(token)
        print(userID)
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/books/sold/\(userID)")!,timeoutInterval: Double.infinity)

        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
               do {
                  let books = try JSONDecoder().decode([GetBook].self, from: data)
                   DispatchQueue.main.async {
                       self.soldBooks.append(contentsOf: books)
                   }
               } catch let error {
                   print(error.localizedDescription)
               }
            }
        }
        task.resume()
    }
    func fetchPurchasedBooks() async throws {
        guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        let token = try Keychain.search()
        print(token)
        print(userID)
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/books/bought/\(userID)")!,timeoutInterval: Double.infinity)

        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
               do {
                  let books = try JSONDecoder().decode([GetBook].self, from: data)
                   DispatchQueue.main.async {
                       self.purchasedBooks.append(contentsOf: books)
                   }
               } catch let error {
                   print(error.localizedDescription)
               }
            }
        }
        task.resume()
    }
    func fetchBooksByCategory(_ forCategory: BookGenre) async {
        do {
            books = try await networkManager.fetchBooksByCategory(forCategory)
        } catch {
            print("unable to fetch books because of : \(error.localizedDescription)")
        }
    }
    func createBook() async {
        do {
            try await networkManager.createBook(title: title,
                                                author: author,
                                                description: description,
                                                genre: genre,
                                                state: state,
                                                status: status,
                                                sellerID: "",
                                                price: price)
        } catch {
            print(error.localizedDescription)
        }
    }
    func purchaseBook(bookID: UUID) async {
        do {
            let id = bookID.uuidString
            print(id)
            try await networkManager.purchaseBook(bookID: id)
        } catch {
            print(error.localizedDescription)
        }
    }
    func deleteBook(id: UUID) async throws {
        do {
            try await networkManager.deleteBook(id: id)
        } catch {
            print(error.localizedDescription)
        }
    }
}
