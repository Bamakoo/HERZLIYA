//
//  CreateBookViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 20/02/2023.
//

import Foundation
import SwiftUI

final class CreateBookViewModel: ObservableObject {
    @Published var books = [Book]()
    private let networkManager: SettingNetworkManager
    
    init(networkManager: SettingNetworkManager) {
        self.networkManager = networkManager
    }
    
    @MainActor
    
    func createBooks(title: String, genre: String, price: Int, author: Author) async throws {
        do {
            try await networkManager.createBook()
        }
        catch {
            print("\(error)")
        }
    }
}
