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
    @Published var myProfile = User.testUser
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
            print(error.localizedDescription )
        }
    }
    func createANewUser() async throws {
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
    //    func updateUserProfile(){
    //        guard let url = URL(string: Request.baseURL + Endpoint.users) else {
    //            print("Error: cannot create URL")
    //            return
    //        }
    //
    //        let updatedProfile = User(id: nil,
    //                                  username: <#T##String#>,
    //                                  email: <#T##String#>,
    //                                  password_hash: nil,
    //                                  password: <#T##String#>,
    //                                  confirmPassword: <#T##String#>,
    //                                  favoriteBook: <#T##String#>,
    //                                  country: <#T##String#>,
    //                                  city: <#T##String#>,
    //                                  favoriteAuthor: <#T##String#>,
    //                                  createdAt: nil,
    //                                  updatedAt: nil,
    //                                  deletedAt: nil)
    //
    //        guard let jsonData = try? JSONEncoder().encode(updatedProfile) else {
    //            print("Error: Trying to convert model to JSON data")
    //            return
    //        }
    //
    //        var request = URLRequest(url: url)
    //        request.httpMethod = "PUT"
    //        request.setValue("application/json", forHTTPHeaderField: HttpHeaders.contentType.rawValue)
    //        let token = "mysuperSecretToken"
    //        request.addValue(("Bearer \(token)"), forHTTPHeaderField: HttpHeaders.authentication.rawValue)
    //        request.httpBody = jsonData
    //        URLSession.shared.dataTask(with: request) { data, response, error in
    //            guard error == nil else {
    //                print("Error: error calling PUT")
    //                print(error!)
    //                return
    //            }
    //            guard let data = data else {
    //                print("Error: Did not receive data")
    //                return
    //            }
    //            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
    //                print("Error: HTTP request failed")
    //                return
    //            }
    //            do {
    //                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
    //                    print("Error: Cannot convert data to JSON object")
    //                    return
    //                }
    //                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
    //                    print("Error: Cannot convert JSON object to Pretty JSON data")
    //                    return
    //                }
    //                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
    //                    print("Error: Could print JSON in String")
    //                    return
    //                }
    //                print(prettyPrintedJson)
    //            } catch {
    //                print("Error: Trying to convert JSON data to string")
    //                return
    //            }
    //        }.resume()
    //    }
    
    func deleteUserProfile(id: UUID) async throws {
        do {
            try await networkManager.deleteProfile(id: id)
        } catch {
            print(error)
        }
    }
}
