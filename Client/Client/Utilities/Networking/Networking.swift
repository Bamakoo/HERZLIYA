//
//  Networking.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//
// TODO: delete update since it's just send data except put
// TODO: rebuild networking with Protocols
import Foundation

final class Networking: HttpClient {
    /// Generic function used to perform GET/READ requests to our Vapor API
    /// - Parameter url: the URL we're going to send the request to
    /// - Returns: an array of whatever object Type we're fetching from the API
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw HttpError.badResponse
        }
        if httpURLResponse.statusCode == 200 {
            guard let object = try? JSONDecoder().decode([T].self, from: data) else {
                throw HttpError.errorDecodingData
            }
            return object
        } else if httpURLResponse.statusCode == 401 {
            throw HttpError.unauthorized
        } else {
            throw HttpError.badResponse
        }
    }
    /// <#Description#>
    /// - Parameter url: <#url description#>
    /// - Returns: <#description#>
    func fetchSingleObject<T: Codable>(url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            throw HttpError.errorDecodingData
        }
        return object
    }
    /// Generic function to send data to the API.
    /// - Parameters:
    ///   - url: the specific URL to send data to the server
    ///   - object: the object sent to the server
    ///   - httpMethod: the method used to send the data
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        request.httpBody = try? JSONEncoder().encode(object)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw HttpError.badResponse
        }
        if httpURLResponse.statusCode == 201 && httpMethod == HttpMethods.POST.rawValue {
            let decoder = JSONDecoder()
            let returnedObject = try decoder.decode(T.self, from: data)
            return returnedObject
        } else if httpURLResponse.statusCode == 200 && httpMethod == HttpMethods.PUT.rawValue {
            let decoder = JSONDecoder()
            let returnedObject = try decoder.decode(T.self, from: data)
            return returnedObject
        } else if httpURLResponse.statusCode == 401 {
            throw HttpError.unauthorized
        } else if httpURLResponse.statusCode == 500 {
            throw HttpError.internalServerError
        } else {
            throw HttpError.badResponse
        }
    }
    /// <#Description#>
    /// - Parameter url: <#url description#>
    func delete(url: URL) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.DELETE.rawValue
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
