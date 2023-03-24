//
//  UsersViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//

import Foundation

final class UsersViewModel: ObservableObject {
    @Published var myProfile: User
    @Published var isLoggedIn: Bool
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
    func createANewUser() async throws {
        do {
            try await networkManager.createUser(username: <#T##String#>, email: <#T##String#>, password_hash: <#T##String#>, password: <#T##String#>, confirmPassword: <#T##String#>, favoriteBook: <#T##String#>, country: <#T##String#>, city: <#T##String#>, favoriteAuthor: <#T##String#>, createdAt: <#T##Date#>, updatedAt: <#T##Date#>, deletedAt: <#T##Date#>)
        } catch {
            print(error)
        }
    }
    func updateUserProfile() async throws {
        do {
            try await networkManager.updateMyProfile()
        } catch {
            print(error)
        }
    }
    func deleteUserProfile(id: UUID) async throws {
        do {
            try await networkManager.deleteProfile(id: id)
        } catch {
            print(error)
        }
    }

}
