//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import Foundation

final class BooksViewModel: ObservableObject {
    @Published var title = ""
    @Published var author = ""
    @Published var description = ""
    @Published var genre: BookGenre = .action
    @Published var state = ""
    @Published var price = 0
    @Published var seller: User
    @Published var status = ""
    @Published var books = [Book]()
    
    private let networkManager: BooksNetworkManager
    init(networkManager: BooksNetworkManager) {
        self.networkManager = networkManager
    }
    @MainActor
    func fetchBooks() async {
        do {
            books = try await networkManager.fetchBooks()
        } catch {
            print("unable to fetch books because of : \(error)")
        }
    }
    
    func createBook() async throws {
        do {
            try await networkManager.createBook(title: title, genre: genre, price: price, author: author, )
        } catch {
            print(error)
        }
    }
}
////    func updateBook(author: String, title: String, id: UUID, price: Int, genre: String, order: Order?) async throws {
//        do {
////            try await networkManager.updateBook(author: author, title: title, id: id, price: price, genre: genre, order: Order(id: nil, price: price))
//        } catch {
//            print(error)
//        }
//    }
//    func deleteBook(id: UUID) async throws {
//        do {
//            try await networkManager.deleteBook(id: id)
//        } catch {
//            print(error)
//        }
//    }
//}
