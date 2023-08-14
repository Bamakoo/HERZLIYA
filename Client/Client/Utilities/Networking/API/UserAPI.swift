//
//  UserAPI.swift
//  Client
//
//  Created by Emma Gaubert on 24/07/2023.
//

import Foundation

extension API {
    struct User {
        static func friendUser(_ userID: UUID) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.friends(userID)).loginProtected()
            _ = try await HTTP.post(with: request, andBody: nil)
        }

        static func login(_ username: String, _ password: String) async throws -> String {
            var request = try HTTPRequestFactory.request(from: NewEndpoint.login())
            guard let data = (username + ":" + password).data(using: .utf8) else {
                throw LoginError.badData
            }
            let encodedData = data.base64EncodedString()
            request.addValue("Basic \(encodedData)", forHTTPHeaderField: "authorization")
            let userTokenData = try await HTTP.post(with: request, andBody: nil)
            let decoder = JSONDecoder()
            let userToken = try decoder.decode(UserToken.self, from: userTokenData)
            return userToken.value
        }

        static func fetch() async throws -> [FetchUser] {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.users()).loginProtected()
            let userData = try await HTTP.get(with: request)
            let decoder = JSONDecoder()
            let users = try decoder.decode([FetchUser].self, from: userData)
            return users

        }

        static func create(_ newUser: NewUser) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.users())
            let encoder = JSONEncoder()
            let userData = try encoder.encode(newUser)
            _ = try await HTTP.post(with: request, andBody: userData)
        }

        static func changePassword(_ patchedPassword: PatchPassword) async throws {
            let request = try HTTPRequestFactory.request(from: NewEndpoint.changePassword()).loginProtected()
            let encoder = JSONEncoder()
            let passwordData = try encoder.encode(patchedPassword)
            _ = try await HTTP.patch(with: request, andBody: passwordData)
        }
    }
}

enum LoginError: Error {
    case badData
}
