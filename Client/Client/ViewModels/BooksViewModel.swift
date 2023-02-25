//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import SwiftUI

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
    
    func updateBook(author: String, id: UUID, title: String, price: Int, genre: String) async throws {
        do {
            print("calling networkManager.updatebook")
            try await networkManager.updateBook(author: author, id: id, title: title, price: price, genre: genre)
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

