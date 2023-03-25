//
//  UserNetworkManager.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//

import Foundation

final class UserNetworkManager {
    let httpClient: HttpClient
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func getMe() async throws -> User {
        guard let url = URL(string: Request.baseURL + Endpoint.me) else {
            print("unable to generate URL to get user profile")
            return 
        }
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
                               email: email, password_hash: nil,
                               password: password, confirmPassword: confirmPassword,
                               favoriteBook: favoriteBook, country: country, city: city, favoriteAuthor: favoriteAuthor,
                               createdAt: nil, updatedAt: nil, deletedAt: nil)
            try await httpClient.sendData(to: url, object: newUser, httpMethod: HttpMethods.POST.rawValue)
        }
    func updateMyProfile(id: UUID,
                        username: String,
                         email: String,
                         password: String,
                         confirmPassword: String,
                         favoriteBook: String,
                         favoriteAuthor: String,
                         city: String,
                         country: String) async throws {
        guard let url = URL(string: Request.baseURL + Endpoint.users) else {
            print("Unable to create valid URL for updating the users' profile")
            return
        }
        let updatedProfile = User(id: <#T##UUID?#>, username: <#T##String#>, email: <#T##String#>, password_hash: <#T##String?#>, password: <#T##String#>, confirmPassword: <#T##String#>, favoriteBook: <#T##String#>, country: <#T##String#>, city: <#T##String#>, favoriteAuthor: <#T##String#>, createdAt: <#T##Date?#>, updatedAt: <#T##Date?#>, deletedAt: <#T##Date?#>)
        try await httpClient.updateData(to: url, object: updatedProfile, httpMethod: HttpMethods.PUT.rawValue)
    }
    func deleteProfile(id: UUID) async throws {
        let url = URL(string: Request.baseURL + Endpoint.users + "/\(id)")!
        try await httpClient.delete(url: url)
    }
    }

