//
//  CommentViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 09/08/2023.
//

import Foundation

@MainActor final class CommentViewModel: ObservableObject {

    @Published var allComments = [Comment]()
    @Published var commentOnBook: Book?

    func fetchAllComments() async throws {
        do {
            allComments = try await UseCase.Comments.fetchAllComments()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchSpecificBook(_ bookID: UUID) async throws {
        do {
            commentOnBook = try await UseCase.Books.fetchSpecificBook(bookID)
        } catch {
            print(error.localizedDescription)
        }
    }
}
