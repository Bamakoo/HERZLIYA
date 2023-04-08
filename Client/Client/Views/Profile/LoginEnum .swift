//
//  LoginEnum .swift
//  Client
//
//  Created by Emma Gaubert on 06/04/2023.
//

import Foundation

struct MenuNavigationItem: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var icon: String
    var menu: MenuItem
}

var menuNavigationItems = [
    MenuNavigationItem(title: "Log In", icon: "trophy.circle", menu: .logIn),
    MenuNavigationItem(title: "Create an account", icon: "person.crop.circle.fill.badge.plus", menu: .createAccount),
    MenuNavigationItem(title: "Forgot my password", icon: "bolt.circle.fill", menu: .forgottenPassword)
]

enum MenuItem: String {
    case forgottenPassword
    case logIn
    case createAccount
}
