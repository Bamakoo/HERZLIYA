//
//  UsersViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 24/03/2023.
//

import Foundation
import SwiftUI

final class UsersViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var favoriteBook = ""
    @Published var favoriteAuthor = ""
    @Published var city = ""
    @Published var country = ""
    @Published var isLoggedIn = User.isLoggedIn
    private let networkManager: UserNetworkManager
    init(networkManager: UserNetworkManager) {
        self.networkManager = networkManager
    }
    @MainActor
    
    func createANewUser() async throws {
        do {
            guard let url = URL(string: Request.baseURL + Endpoint.users) else {
                print("unable to generate an URL to create a new user")
                return
            }
            var request = URLRequest(url: url)
            request.httpMethod = HttpMethods.POST.rawValue
            request.addValue(MIMEType.JSON.rawValue,
                             forHTTPHeaderField: HttpHeaders.contentType.rawValue)
            let encoder = JSONEncoder()
            let newUser = NewUser(username: username,
                                  email: email,
                                  password: password,
                                  confirmPassword: confirmPassword,
                                  favoriteBook: favoriteBook,
                                  favoriteAuthor: favoriteAuthor,
                                  city: city, country: country)
            request.httpBody = try? encoder.encode(newUser)
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpURLResponse = response as? HTTPURLResponse else {
                throw HttpError.badResponse
            }
            if httpURLResponse.statusCode == 201 {
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(GetUser.self, from: data)
                    var userID = "\(user.id)"
                    UserDefaults.standard.set(userID, forKey: "userID")
                } catch {
                    print(error.localizedDescription)
                }
            } else if httpURLResponse.statusCode == 401 {
                throw HttpError.unauthorized
            } else {
                    throw HttpError.badResponse
                }
            } catch {
            print(error.localizedDescription)
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
