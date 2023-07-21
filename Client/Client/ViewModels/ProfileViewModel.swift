//
//  ProfileViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 21/07/2023.
//

import Foundation
@MainActor
final class ProfileViewModel: ObservableObject {
    @TokenRepository<String>
    var token: String?
    @Published var likedBooks = [Book]()
    
    func fetchLikedBooks() async throws {
        likedBooks = [Book]()
        likedBooks = try await UseCase.Books.fetchLikedBooks()
    }
}
