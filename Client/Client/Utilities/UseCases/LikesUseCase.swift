//
//  LikesUseCase.swift
//  Client
//
//  Created by Emma Gaubert on 17/08/2023.
//

import Foundation

extension UseCase {
    struct Likes {
        static func fetchAllLikes() async throws -> [Like] {
            try await API.Likes.fetchLikes()
        }
    }
}
