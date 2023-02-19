//
//  BooksViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 18/02/2023.
//

import SwiftUI

final class AuthorsViewModel: ObservableObject {
    @Published var authors = [Author]()
    private let networkManager: SettingNetworkManager
    
    init(networkManager: SettingNetworkManager) {
        self.networkManager = networkManager
    }
    @MainActor
    func fetchAuthors() async {
        do {
            authors = try await networkManager.fetchAuthors()
        }
        catch {
            print("\(error)")
        }
    }
    
    func createAuthors(firstName: String, lastName: String) async throws {
        do {
            try await networkManager.createAuthor(firstName: firstName, lastName: lastName)
        }
        catch {
            
        }
    }
}
