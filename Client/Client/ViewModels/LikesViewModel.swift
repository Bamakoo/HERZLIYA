//
//  LikesViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 17/08/2023.
//

import Foundation

@MainActor final class LikesViewModel: ObservableObject {

    @Published var allLikes = [Like]()

    func fetchAllLikes() async throws {
        do {
            allLikes = try await UseCase.Likes.fetchAllLikes()
        } catch {
            print(error.localizedDescription)
        }
    }
}
