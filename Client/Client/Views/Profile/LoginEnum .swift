//
//  LoginEnum .swift
//  Client
//
//  Created by Emma Gaubert on 06/04/2023.
//

import Foundation

enum MenuItem: Identifiable, CaseIterable {
    case forgottenPassword
    case logIn
    case createAccount
    var id: Self { self }
    var title: String {
        switch self {
            case .forgottenPassword: return "Forgot my password"
            case .logIn: return "Log in"
            case .createAccount: return "Create Account"
        }
    }
    var image: String {
        switch self {
        case .forgottenPassword: return "bolt.circle.fill"
        case .logIn: return "trophy.circle"
        case .createAccount: return "person.crop.circle.fill.badge.plus"
        }
    }
}
