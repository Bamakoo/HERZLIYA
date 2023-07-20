//
//  HttpClient.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//

import Foundation

enum HttpMethods: String {
    case POST, GET, PUT, DELETE, PATCH
}

enum MIMEType: String {
    case JSON = "application/json"
}

enum HttpHeaders: String {
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case accept = "Accept"
    case authentication = "Authentication"
}

enum UserError: Error {
    case unableToGetID
}

enum HttpError: Error {
    case badURL
    case badResponse
    case errorDecodingData
    case internalServerError
    case notFound
    case unauthorized
    case requestFailed(description: String)
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonConversionFailure(description: String)
    case jsonParsingFailure
    case failedSerialization
    case noInternet
    var customDescription: String {
        switch self {
        case let .requestFailed(description): return "Request Failed: \(description)"
        case .invalidData: return "Invalid Data)"
        case let .responseUnsuccessful(description): return "Unsuccessful: \(description)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure: \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure"
        case .failedSerialization: return "Serialization failed."
        case .noInternet: return "No internet connection"
        default: return "error"
        }
    }
}

protocol HttpClient {
    func fetch<T: Codable>(url: URL) async throws -> [T]
    func fetchSingleObject<T: Codable>(url: URL) async throws -> T
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws -> T
    func delete(url: URL) async throws
}
