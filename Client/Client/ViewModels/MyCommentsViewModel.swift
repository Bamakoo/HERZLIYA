//
//  MyCommentsViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 04/07/2023.
//

import Foundation

@MainActor final class MyCommentsViewModel: ObservableObject {

    @Published var myComments = [Comment]()
    @Published var commentsOnMyBooks = [Comment]()

    func fetchMyComments() async throws {
        do {
            myComments = try await UseCase.Comments.fetchMyComments()
        } catch {
            print(error.localizedDescription)
        }
    }

    func fetchCommentsOnMySoldBooks() async throws {
        do {
            commentsOnMyBooks = try await UseCase.Comments.fetchCommentsOnMyBooks()
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateComment() async throws {
        print("hello")
    }

    func deleteComment(_ commentID: UUID?) async throws {
        do {
            guard let commentID else {
                return
            }
            try await UseCase.Comments.delete(commentID)
        } catch {
            print(error.localizedDescription)
        }
    }
}
