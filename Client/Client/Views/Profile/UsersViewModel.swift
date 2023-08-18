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
