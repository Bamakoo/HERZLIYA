//
//  CommentsUseCase.swift
//  Client
//
//  Created by Emma Gaubert on 26/07/2023.
//

import Foundation

extension UseCase {
    struct Comments {
        static func fetchCommentsOnBook(_ bookID: UUID) async throws -> [Comment] {
            let comments = try await API.Comments.fetchCommentsOnBook(bookID)
            return comments
        }
        
        static func fetchAllComments() async throws -> [Comment] {
            let comments = try await API.Comments.fetchAllComments()
            return comments
        }

        static func fetchMyComments() async throws -> [Comment] {
            let comments = try await API.Comments.fetchMyComments()
            return comments
        }

        static func commentOnBook(_ newComment: PostComment) async throws {
            try await API.Comments.commentOnBook(newComment)
        }

        static func delete(_ commentID: UUID) async throws {
            try await API.Comments.delete(commentID)
        }
    }
}
