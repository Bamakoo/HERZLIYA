//
//  CommentsAPI.swift
//  Client
//
//  Created by Emma Gaubert on 26/07/2023.
//

import Foundation

extension API {
    struct Comments {
        static func fetchCommentsOnBook(_ bookID: UUID) async throws -> [Comment] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.commentsOnBook(bookID)).loginProtected()
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
    }
}
