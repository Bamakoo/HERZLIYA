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
    @Published var isSorting: Bool = false
    @Published var sortAscending: Bool = false
    @Published var selectedDisplay: WhatToDisplay = .books
    @Published var sortOrFilter: SortOrFilter = .filter
    @Published var selectedFilter: Filters = .genre(.action)
    @Published var selectedSort: SortBy = .genre
    @Published var selectedMenu: HomepageMenuSelector = .display
    @Published var selectedSubMenu: HomepageSubMenuSelector = .author
    private let networkManager: HomepageNetworkManager
    init(networkManager: HomepageNetworkManager) {
        self.networkManager = networkManager
    }
    
    func likeABook(_ book: Book) async {
        do {
            _ = try await networkManager.likeABook(book)
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
    func sort() async {
        do {
            books = try await networkManager.sort(selectedSort, sortAscending)
            print(sortedBooks)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addBookToKart(_ bookID: UUID) async {
        do {
                try await networkManager.addBookToKart(bookID)
            print("done adding book to kart")
        } catch {
            print(error.localizedDescription)
        }
    }
}
