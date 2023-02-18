//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import SwiftUI

final class BooksViewModel: ObservableObject {
    @Published var books = [Book]()
    private let networkManager: SettingNetworkManager
    
    init(networkManager: SettingNetworkManager) {
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
}
