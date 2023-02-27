//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

final class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    
    private let networkManager: BooksNetworkManager
    
    init(networkManager: BooksNetworkManager) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func fetchBooks() async {
        do {
            books = try await networkManager.fetchBooks()
        }
        catch {
            print("\(error)")
        }
    }
    func createBook(title: String, genre: String, price: Int, author: String) async throws {
        do {
            try await networkManager.createBook(title: title, genre: genre, price: price, author: author)
        }
        catch {
            print("\(error)")
        }
    }
    
    func updateBook(author: String, title: String, id: UUID, price: Int, genre: String) async throws {
        do {
            try await networkManager.updateBook(author: author, title: title, id: id, price: price, genre: genre)
        }
        catch {
            print(error)
        }
    }
    func deleteBook(id: UUID) async throws {
        do {
            try await networkManager.deleteBook(id: id)
        }
        catch {
            print(error)
        }
    }
}

