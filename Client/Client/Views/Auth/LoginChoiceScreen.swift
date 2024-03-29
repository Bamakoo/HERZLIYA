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
            List(MenuItem.allCases) { item in
                NavigationLink(value: item) {
                    Label(item.title, systemImage: item.image)
                        .foregroundColor(.primary)
                }
            }
            .listStyle(.automatic)
            .navigationTitle("Connect to your account")
            .navigationBarTitleDisplayMode(.large)
            .navigationDestination(for: MenuItem.self) { item in
                switch item {
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
