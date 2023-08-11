//
//  Networking.swift
//  Client
//
//  Created by Emma Gaubert on 17/02/2023.
//
import Foundation

final class Networking: HttpClient {
    @TokenRepository<String>
    var token: String?
    /// Generic function used to perform GET/READ requests to our Vapor API
    /// - Parameter url: the URL we're going to send the request to
    /// - Returns: an array of whatever object Type we're fetching from the API
    func fetch<T: Codable>(url: URL) async throws -> [T] {
        var request = URLRequest(url: url)
        // guard let userID = UserDefaults.standard.string(forKey: "userID") else { throw UserError.unableToGetID }
        _ = "70935759-4231-43E4-8E54-92CA3A48E33B"
        if let token {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = "GET"
        let (data, response) = try await URLSession.shared.data(from: url)
        print(data, response)
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
    /// Get request to return a single instance of an object
    /// - Parameter url: the URL to get the object
    /// - Returns: the request object
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
    /// Generic function to send data to the API ie perform PUT, PATCH and POST requests
    /// - Parameters:
    ///   - url: the specific URL to send data to the server
    ///   - object: the object sent to the server
    ///   - httpMethod: the method used to send the data
    func sendData<T: Codable>(to url: URL, object: T, httpMethod: String) async throws -> T {
        print("sending data")
        var request = URLRequest(url: url)
        print(request)
        request.httpMethod = httpMethod
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        _ = "70935759-4231-43E4-8E54-92CA3A48E33B"
        if let token {
            request.setValue("Bearer \(token)", forHTTPHeaderField: HttpHeaders.authorization.rawValue)
        }
        request.httpBody = try? JSONEncoder().encode(object)
        let (data, response) = try await URLSession.shared.data(for: request)
        print(data, response)
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw HttpError.badResponse
        }
        print(httpURLResponse)
        if httpURLResponse.statusCode == 201 && httpMethod == HttpMethods.POST.rawValue {
            print("The response code is \(httpURLResponse.statusCode)")
            let decoder = JSONDecoder()
            let returnedObject = try decoder.decode(T.self, from: data)
            return returnedObject
        } else if httpURLResponse.statusCode == 200 && httpMethod == HttpMethods.PUT.rawValue {
            print("The response code is \(httpURLResponse.statusCode)")
            let decoder = JSONDecoder()
            let returnedObject = try decoder.decode(T.self, from: data)
            return returnedObject
        } else if httpURLResponse.statusCode == 401 {
            print("The response code is \(httpURLResponse.statusCode)")
            throw HttpError.unauthorized
        } else if httpURLResponse.statusCode == 404 {
            print("hello world")
            throw HttpError.notFound
        } else if httpURLResponse.statusCode == 500 {
            throw HttpError.internalServerError
        } else {
            throw HttpError.badResponse
        }
    }
    /// A generic function, used to delete a single Object in the Table
    /// - Parameter url: the URL to send the delete request to,
    /// this also contains the identifier for the object we want to delete
    func delete(url: URL) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.DELETE.rawValue
        let (_, response) = try await URLSession.shared.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HttpError.badResponse
        }
    }
}
