//
//  UserAPI.swift
//  Client
//
//  Created by Emma Gaubert on 24/07/2023.
//

import Foundation

extension API {
    struct User {
        static func login(_ username: String, _ password: String) async throws {
            var request = try HTTPRequestFactory.request(from: NewEndpoint.login())
            let authData = (username + ":" + password).data(using: .utf8)!.base64EncodedString()
            request.addValue("Basic \(authData)", forHTTPHeaderField: HttpHeaders.authorization.rawValue)
            try await HTTP.post(with: request, andBody: Data())
        }
    }
}
