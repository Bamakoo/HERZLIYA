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
    @Published var soldBooks = [Book]()
    @Published var purchasedBooks = [Book]()
    @Published var myFriends = [FetchUser]()

    func fetchMyFriends() async throws {
        do {
            myFriends = try await UseCase.User.fetchMyFriends()
        } catch {
            print(error.localizedDescription)
        }
    }

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

    func soldBooks() async throws {
        do {
            soldBooks = try await UseCase.Books.fetchSoldBooks()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchPurchasedBooks() async throws {
        do {
            purchasedBooks = try await UseCase.Books.fetchBoughtBooks()
        } catch {
            print(error.localizedDescription)
        }
    }
}
