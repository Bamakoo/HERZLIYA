//
//  KartViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 27/07/2023.
//

import Foundation
@MainActor
final class KartViewModel: ObservableObject {
    
    @Published var kartBooks = [Book]()

    func getBooksInKart() async throws {
        do {
            kartBooks = try await UseCase.Cart.fetchBooksInKart()
        } catch {
            print(error.localizedDescription)
        }
    }

    func removeBookFromKart(_ bookID: UUID) async throws {
        do {
            try await UseCase.Cart.removeBookFromCart(bookID)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func buyBook(_ bookID: UUID) async throws {
        do {
            try await UseCase.Books.buyBook(bookID)
        } catch {
            print(error.localizedDescription)
        }
    }
}
