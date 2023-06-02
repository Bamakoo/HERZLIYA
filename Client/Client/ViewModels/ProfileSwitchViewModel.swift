//
//  ProfileSwitchViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 02/06/2023.
//

import Foundation

final class ProfileSwitchViewModel: ObservableObject {
    func isLoggedIn() -> Bool {
        do {
            var token = try Keychain.search()
            guard token.isEmpty else {
                return true
            }
            return false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
