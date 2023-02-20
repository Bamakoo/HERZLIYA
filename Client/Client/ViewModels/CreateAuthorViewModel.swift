//
//  CreateAuthorViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import SwiftUI

final class CreateAuthorViewModel: ObservableObject {
    @Published var authors = [Author]()
    private let networkManager: SettingNetworkManager
    
    init(networkManager: SettingNetworkManager) {
        self.networkManager = networkManager
    }
    @MainActor
    
    func createAuthors(firstName: String, lastName: String) async throws {
        do {
            try await networkManager.createAuthor(firstName: firstName, lastName: lastName)
        }
        catch {
            print("\(error)")
        }
    }
}
