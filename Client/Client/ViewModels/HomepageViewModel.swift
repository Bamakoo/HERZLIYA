//
//  HomepageViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 31/05/2023.
//

import Foundation

@MainActor
final class HomepageViewModel: ObservableObject {

    @Published var books = [Book]()
    @Published var sortedBooks = [Book]()
    @Published var sortAscending: Bool = false
    @Published var selectedSort: SortBy = .genre

    private let networkManager: HomepageNetworkManager

    init(networkManager: HomepageNetworkManager) {
        self.networkManager = networkManager
    }

    func likeABook(_ book: Book) async {
        do {
            guard let bookID = book.id else {
                return
            }
                try await UseCase.Books.likeABook(bookID)
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

    func fetchBooks() async {
        do {
            books = try await UseCase.Books.fetch()
        } catch {
            print("unable to fetch books because of : \(error.localizedDescription)")
        }
    }

    func sort() async {
        do {
            let queryItems: [URLQueryItem] =
            [
                URLQueryItem(name: "by", value: selectedSort.rawValue),
                URLQueryItem(name: "ascending", value: String(sortAscending))
            ]
            books = try await UseCase.Books.sort(queryItems)
        } catch {
            print(error.localizedDescription)
        }
    }

    func addBookToKart(_ bookID: UUID) async {
        do {
            try await UseCase.Books.addBookToKart(bookID)
        } catch {
            print(error.localizedDescription)
        }
    }
}
