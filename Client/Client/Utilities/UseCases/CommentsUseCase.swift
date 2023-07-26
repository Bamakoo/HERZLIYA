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
    }
}
