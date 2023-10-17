//
//  ProfileSwitchViewModel.swift
//  Client
//
//  Created by Emma Gaubert on 02/06/2023.
//

import Foundation

final class ProfileSwitchViewModel: ObservableObject {
    @TokenRepository<Any>
    var token: String?
    func isLoggedIn() -> Bool {
        return token != nil
    }
}
