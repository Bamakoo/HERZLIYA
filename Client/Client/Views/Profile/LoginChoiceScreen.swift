//
//  LoginChoiceScreen.swift
//  Client
//
//  Created by Emma Gaubert on 06/04/2023.
//

import SwiftUI

struct LoginChoiceScreen: View {
    var body: some View {
        NavigationStack {
            List(menuNavigationItems) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.icon)
                        .foregroundColor(.primary)
                }
            }
            .listStyle(.automatic)
            .navigationTitle("Connect to your account")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: MenuNavigationItem.self) { item in
                switch item.menu {
                case .forgottenPassword:
                    ForgotMyPasswordView()
                case .logIn:
                    SignInView()
                case .createAccount:
                    CreateAccountView()
                }
            }
        }
    }
}

struct LoginChoiceScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginChoiceScreen()
    }
}
