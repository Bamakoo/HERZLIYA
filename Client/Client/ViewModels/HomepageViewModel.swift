//
//  HomepageViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 31/05/2023.
//

import Foundation

@MainActor
final class HomepageViewModel: ObservableObject {
    @Published var books = [GetBook]()
    @Published var selectedDisplay: WhatToDisplay = .books
    @Published var sortOrFilter: SortOrFilter = .filter
    @Published var selectedFilter: Filters = .genre(.action)
    @Published var selectedMenu: HomepageMenuSelector = .display
    @Published var selectedSubMenu: HomepageSubMenuSelector = .author
    private let networkManager: HomepageNetworkManager
    init(networkManager: HomepageNetworkManager) {
        self.networkManager = networkManager
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
            books = try await networkManager.sort(selectedMenu, selectedSubMenu)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func filter() async {
        do {
            books = try await networkManager.sort(selectedMenu, selectedSubMenu)
        } catch {
            print(error.localizedDescription)
        }
    }
}
