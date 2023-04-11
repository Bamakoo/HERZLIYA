//
//  LoginChoiceScreen.swift
//  Client
//
//  Created by Emma Gaubert on 06/04/2023.
//
// TODO: change password/profile 
import SwiftUI

struct LoginChoiceScreen: View {
    @State private var menuItems: [MenuItem] = MenuItem.allCases
    var body: some View {
        NavigationStack {
            List(menuItems) { item in
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
