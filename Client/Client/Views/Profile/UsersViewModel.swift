//
//  UsersViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//

import Foundation
import SwiftUI

@MainActor final class UsersViewModel: ObservableObject {

    @Published var users = [FetchUser]()
    @Published var currentPassword = String()
    @Published var confirmCurrentPassword = String()
    @Published var newPassword = String()
    @Published var confirmNewPasswordd = String()
    @Published var username = String()
    @Published var email = String()
    @Published var password = String()
    @Published var confirmPassword = String()
    @Published var favoriteBook = String()
    @Published var favoriteAuthor = String()
    @Published var city = String()
    @Published var country = String()

    func friendUser(_ userID: UUID) async throws {
        do {
            try await UseCase.User.friendUser(userID)
        } catch {
            print(error.localizedDescription)
        }
    }

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

    func fetchUsers() async throws {
        do {
            users = try await UseCase.User.fetchUsers()
        } catch {
            print(error.localizedDescription)
        }
    }

    func changeUserPassword() async throws {
        do {
            let patchedPassword = PatchPassword(currentPassword: currentPassword,
                                                confirmCurrentPassword: confirmCurrentPassword,
                                                newPassword: newPassword,
                                                confirmNewPassword: confirmNewPasswordd,
                                                favoriteAuthor: favoriteAuthor,
                                                favoriteBook: favoriteBook)
            try await UseCase.User.changePassword(patchedPassword)
        } catch {
            print(error.localizedDescription)
        }
    }
}
