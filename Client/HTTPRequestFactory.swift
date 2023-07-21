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
    func loginProtected() -> URLRequest {
        var request = self
        @TokenRepository<String?>
         var token: String?
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        return request
    }
}
