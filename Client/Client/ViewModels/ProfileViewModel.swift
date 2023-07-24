//
//  ProfileViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 21/07/2023.
//

import Foundation
@MainActor
final class ProfileViewModel: ObservableObject {
    
    @TokenRepository<String>
    var token: String?
    
    @Published var likedBooks = [Book]()
    @Published var booksByUsersFavoriteAuthor = [Book]()
    @Published var kartBooks = [Book]()
    @Published var soldBooks = [Book]()
    
    func fetchLikedBooks() async throws {
        do {
            likedBooks = try await UseCase.Books.fetchLikedBooks()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func bookByUsersFavoriteAuthor() async throws {
        do {
            booksByUsersFavoriteAuthor = try await UseCase.Books.fetchBookByUsersFavoriteAuthor()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getBooksInKart() async throws {
        do {
            kartBooks = try await UseCase.Books.fetchBooksInKart()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func soldBooks() async throws {
        do {
            soldBooks = try await UseCase.Books.fetchSoldBooks()
        } catch {
            print(error.localizedDescription)
        }
    }
}
