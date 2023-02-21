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
}

enum HttpError: Error {
    case badURL
    case badResponse
    case errorDecodingData
    case unauthorized
}

protocol HttpClient {
    func fetch<T: Codable>(url: URL) async throws -> [T]
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws
}






    

