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
    func changePassword(with DTO: PatchPassword) async throws {
        guard let url = URL(string: "http://127.0.0.1:8080/change-password") else {
            return
        }
        _ = try await httpClient.sendData(to: url, object: DTO, httpMethod: HttpMethods.PATCH.rawValue)
    }
    func getMe() async throws -> User {
        let url = URL(string: Request.baseURL + Endpoint.myself)!
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
        _ = try await httpClient.sendData(to: url, object: newUser, httpMethod: HttpMethods.POST.rawValue)
    }
    
    func deleteProfile(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.users + "/\(id)")!
        try await httpClient.delete(url: url)
    }
}

