//
//  UserNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//
// swiftlint:disable all


import Foundation

final class UserNetworkManager {
    let httpClient: HttpClient
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    func getMe() async throws -> User {
        let url = URL(string: Request.baseURL + Endpoint.me)!
        let myProfile: User = try await httpClient.fetchSingleObject(url: url)
        return myProfile
    }
    func createUser(username: String,
                    email: String,
                    password: String,
                    confirmPassword: String,
                    favoriteBook: String,
                    favoriteAuthor: String,
                    city: String,
                    country: String) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.users) else {
            print("Unable to create valid URL for creating a new user")
            return
        }
        let newUser = User(id: nil,
                           username: username,
                           email: email,
                           password_hash: nil,
                           password: password,
                           confirmPassword: confirmPassword,
                           favoriteBook: favoriteBook,
                           country: country,
                           city: city,
                           favoriteAuthor: favoriteAuthor,
                           createdAt: nil,
                           updatedAt: nil,
                           deletedAt: nil)
        try await httpClient.sendData(to: url, object: newUser, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func deleteProfile(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.users + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}

