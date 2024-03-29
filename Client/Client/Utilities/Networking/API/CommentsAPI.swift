//
//  CommentsAPI.swift
//  Client
//
//  Created by Emma Gaubert on 26/07/2023.
//

import Foundation

extension API {
    struct Comments {

        static func fetchCommentsOnMyBooks() async throws -> [Comment] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.commentsOnMyBooks()).loginProtected()
            let commentData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let comments = try decoder.decode([Comment].self, from: commentData)
            return comments
        }

        static func fetchCommentsOnBook(_ bookID: UUID) async throws -> [Comment] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.commentsOnBook(bookID)).loginProtected()
            let commentData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let comments = try decoder.decode([Comment].self, from: commentData)
            return comments
        }

        static func fetchAllComments() async throws -> [Comment] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.comments())
            let commentData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let comments = try decoder.decode([Comment].self, from: commentData)
            return comments
        }

        static func fetchMyComments() async throws -> [Comment] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.myComments()).loginProtected()
            let commentData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let comments = try decoder.decode([Comment].self, from: commentData)
            return comments
        }

        static func commentOnBook(_ newComment: PostComment) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.comments()).loginProtected()
            let encoder = JSONEncoder()
            let commentData = try encoder.encode(newComment)
            _ = try await HTTP.post(with: request, andBody: commentData)
        }

        static func delete(_ commentID: UUID) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.deleteComment(commentID)).loginProtected()
            _ = try await HTTP.delete(with: request)
        }
    }
}
