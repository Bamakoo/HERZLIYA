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

    private let networkManager: HomepageNetworkManager
    init(networkManager: HomepageNetworkManager) {
        self.networkManager = networkManager
    }
    func fetchBooks() async {
        do {
            print("I'm using the NEW VM")
            books = try await networkManager.fetchBooks()
        } catch {
            print("unable to fetch books because of : \(error.localizedDescription)")
        }
    }
}
