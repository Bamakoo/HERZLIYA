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
    @Published var seller: User = User.testUser
    @Published var status: BookStatus = .available
    @Published var books = [GetBook]()
    @Published var purchasedBooks = [GetBook]()
    private let networkManager: BooksNetworkManager
    init(networkManager: BooksNetworkManager) {
        self.networkManager = networkManager
    }
    func fetchBooks() async {
        do {
            books = try await networkManager.fetchBooks()
        } catch {
            print("unable to fetch books because of : \(error.localizedDescription)")
        }
    }
    func fetchPurchasedBooks() async {
        do {
            print("starting to fetch purchased books")
            purchasedBooks = try await networkManager.fetchPurchasedBooks()
            print(purchasedBooks)
        } catch {
            print(error.localizedDescription)
        }
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
                                                status: status, sellerID: "",
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
