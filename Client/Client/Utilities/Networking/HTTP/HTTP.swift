//
//  HTTP.swift
//  Client
//
//  Created by Emma Gaubert on 05/07/2023.
//

import Foundation

protocol HTTPService {
    static func get(with request: URLRequest, using session: URLSession) async throws -> Data
    static func post(with request: URLRequest, andBody body: Data?, using session: URLSession) async throws -> Data
    static func patch(with request: URLRequest, andBody body: Data?, using session: URLSession) async throws -> Data
    static func delete(with request: URLRequest, using session: URLSession) async throws -> Data
}

struct HTTP: HTTPService {
    static func get(with request: URLRequest, using session: URLSession = .shared) async throws -> Data {
        var request = request
        request.httpMethod = "GET"
        return try await executeRequest(request: request, session: session)
    }
    static func post(with request: URLRequest,
                     andBody body: Data?,
                     using session: URLSession = .shared) async throws -> Data {
        var request = request
        request.httpMethod = "POST"
        request.httpBody = body
        return try await executeRequest(request: request, session: session)
    }
    static func patch(with request: URLRequest,
                      andBody body: Data?,
                      using session: URLSession = .shared) async throws -> Data {
        var request = request
        request.httpMethod = "PATCH"
        request.httpBody = body
        return try await executeRequest(request: request, session: session)
    }
    static func delete(with request: URLRequest, using session: URLSession = .shared) async throws -> Data {
        var request = request
        request.httpMethod = "DELETE"
        return try await executeRequest(request: request, session: session)
    }
}

private extension HTTP {
    static func executeRequest(request: URLRequest, session: URLSession) async throws -> Data {
        let (data, response) = try await session.data(for: request)

        if let httpResponse = response as? HTTPURLResponse,
           !(200...299).contains(httpResponse.statusCode) {
            throw HttpError.badResponse
        }

        return data
    }
}
