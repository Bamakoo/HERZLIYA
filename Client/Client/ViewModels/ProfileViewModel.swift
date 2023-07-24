//
//  ProfileViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 21/07/2023.
//

import Foundation
@MainActor
final class ProfileViewModel: ObservableObject {

    @Published var likedBooks = [Book]()
    @Published var booksByUsersFavoriteAuthor = [Book]()

    
    func fetchLikedBooks() async throws {
        do {
            likedBooks = [Book]()
            likedBooks = try await UseCase.Books.fetchLikedBooks()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func bookByUsersFavoriteAuthor() async throws {
        do {
            booksByUsersFavoriteAuthor = [Book]()
            booksByUsersFavoriteAuthor = try await UseCase.Books.fetchBookByUsersFavoriteAuthor()
        } catch {
            print(error.localizedDescription)
        }
    }
}
