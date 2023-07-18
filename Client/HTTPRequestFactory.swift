//
//  HTTPRequestFactory.swift
//  Client
//
//  Created by Emma Gaubert on 05/07/2023.
//

import Foundation

struct HTTPRequestFactory {
    static func request(from endpoint: APIEndpoint) throws -> URLRequest {
        guard let url = endpoint.url else {
            throw HttpError.badURL
        }
        return URLRequest(url: url)
    }
}

extension URLRequest {
    mutating func loginProtected() -> URLRequest {
        @TokenRepository<String?>
         var token: String?
        if let token {
            self.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return self
    }
}
