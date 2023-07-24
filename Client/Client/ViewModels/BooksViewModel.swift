//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation
@MainActor
final class BooksViewModel: ObservableObject {
    @TokenRepository<String>
    var token: String?
  
    @Published var title = ""
    @Published var author = ""
    @Published var description = ""
    @Published var genre: BookGenre = .action
    @Published var state: BookState = .acceptable
    @Published var price = 0
    @Published var status: BookStatus = .available
    @Published var books = [Book]()
    @Published var purchasedBooks = [Book]()
    @Published var booksByUsersFavoriteAuthor = [Book]()
    @Published var searchText: String = ""
    @Published var searchResults = [Book]()
    @Published var commentsOnBook = [Comment]()
    
    private let networkManager: BooksNetworkManager
    init(networkManager: BooksNetworkManager) {
        self.networkManager = networkManager
    }
    
    func getCommentsOnBook(_ bookID: UUID) async throws {
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/comments/\(bookID)")!,timeoutInterval: Double.infinity)
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let comments = try JSONDecoder().decode([Comment].self, from: data)
                    DispatchQueue.main.async {
                        self.commentsOnBook.append(contentsOf: comments)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func commentOnBook(_ bookID: UUID, _ comment: String) async throws {
        do {
            try await networkManager.commentOnBook(bookID, comment)
        } catch {
            print(error.localizedDescription)
        }
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
            guard !searchText.isEmpty else { return }
            searchResults = try await networkManager.searchBooks(searchText)
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
    

    
    func fetchPurchasedBooks() async throws {
        purchasedBooks = [Book]()
        var request = URLRequest(url: URL(string: "http://127.0.0.1:8080/books/bought")!, timeoutInterval: Double.infinity)
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let books = try JSONDecoder().decode([Book].self, from: data)
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
                                                price: price)
            description = ""
            price = 1
            title = ""
            author = ""
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func purchaseBook(bookID: UUID) async {
        do {
            let id = bookID.uuidString
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
