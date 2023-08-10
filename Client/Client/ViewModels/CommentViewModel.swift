//
//  CommentViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 09/08/2023.
//

import Foundation

@MainActor

final class CommentViewModel: ObservableObject {

    @Published var allComments = [Comment]()

    func fetchAllComments() async throws {
        do {
            allComments = try await UseCase.Comments.fetchAllComments()
        } catch {
            print(error.localizedDescription)
        }
    }
}
