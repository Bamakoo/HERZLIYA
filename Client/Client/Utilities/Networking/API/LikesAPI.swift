//
//  LikesAPI.swift
//  Client
//
//  Created by Emma Gaubert on 17/08/2023.
//

import Foundation

extension API {
    struct Likes {
        static func fetchLikes() async throws -> [Like] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.likes()).loginProtected()
            let likesData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let likes = try decoder.decode([Like].self, from: likesData)
            return likes
        }
    }
}
