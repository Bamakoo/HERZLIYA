//
//  UsersViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//

import Foundation
import SwiftUI

final class UsersViewModel: ObservableObject {

    @Published var currentPassword = ""
    @Published var confirmCurrentPassword = ""
    @Published var newPassword = ""
    @Published var confirmNewPasswordd = ""
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var favoriteBook = ""
    @Published var favoriteAuthor = ""
    @Published var city = ""
    @Published var country = ""

    private let networkManager: UserNetworkManager

    init(networkManager: UserNetworkManager) {
        self.networkManager = networkManager
    }

    @MainActor
    func createANewUser() async throws {
        do {
            let newUser = NewUser(username: username,
                                  email: email,
                                  password: password,
                                  confirmPassword: confirmPassword,
                                  favoriteBook: favoriteBook,
                                  favoriteAuthor: favoriteAuthor,
                                  city: city,
                                  country: country)
            try await UseCase.User.createNewUser(newUser)
        } catch {
            print(error.localizedDescription)
        }
    }

    func changeUserPassword() async throws {
        do {
            let patchedPassword = PatchPassword(id: "D9C1869E-1250-4610-B49C-5EC2E3949885",
                                                currentPassword: currentPassword,
                                                confirmCurrentPassword: confirmCurrentPassword,
                                                newPassword: newPassword,
                                                confirmNewPassword: confirmNewPasswordd,
                                                favoriteAuthor: favoriteAuthor,
                                                favoriteBook: favoriteBook)
            try await networkManager.changePassword(with: patchedPassword)
        } catch {
            print(error.localizedDescription)
        }
    }

    func deleteUserProfile(id: UUID) async throws {
        do {
            try await networkManager.deleteProfile(id: id)
        } catch {
            print(error.localizedDescription)
        }
    }
}
