//
//  UsersViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//

import Foundation
import SwiftUI

final class UsersViewModel: ObservableObject {
    @Published var myProfile: User
    @Published var isLoggedIn: Bool = false
    private let networkManager: UserNetworkManager
    init(networkManager: UserNetworkManager) {
        self.networkManager = networkManager
    }
    @MainActor
    func getMyProfile() async {
        do {
            myProfile = try await networkManager.getMe()
        } catch {
            print("unable to get my profile because of \(error)")
        }
    }
    func createANewUser(username: String,
                        email: String,
                        password: String,
                        confirmPassword: String,
                        favoriteBook: String,
                        favoriteAuthor: String,
                        city: String,
                        country: String) async throws {
        do {
            try await networkManager.createUser(username: username,
                                                email: email,
                                                password: password,
                                                confirmPassword: confirmPassword,
                                                favoriteBook: favoriteBook,
                                                favoriteAuthor: favoriteAuthor,
                                                city: city,
                                                country: country)
        } catch {
            print(error)
        }
    }
//    func updateUserProfile() async throws {
//        do {
//            try await networkManager.updateMyProfile(id: <#T##UUID#>, username: <#T##String#>, email: <#T##String#>, password: <#T##String#>, confirmPassword: <#T##String#>, favoriteBook: <#T##String#>, favoriteAuthor: <#T##String#>, city: <#T##String#>, country: <#T##String#>)
//        } catch {
//            print(error)
//        }
//    }
    func deleteUserProfile(id: UUID) async throws {
        do {
            try await networkManager.deleteProfile(id: id)
        } catch {
            print(error)
        }
    }
    func handleLogin(username: String, password: String) {
        isLoggedIn.toggle()
    }
}
