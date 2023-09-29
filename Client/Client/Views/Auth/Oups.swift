//
//  Oups.swift
//  Client
//
//  Created by Emma Gaubert on 27/05/2023.
//

import SwiftUI

struct Oups: View {
    @State private var createAnAccount = false
    @State private var signIn = false
    @ObservedObject var viewModel = SignInViewModel()
    @EnvironmentObject var loginManager: LoginManager

    var body: some View {
        VStack(alignment: .center, spacing: 20) {
            Text("Sign in to access your profile")
                .font(.title)
            VStack(alignment: .center, spacing: 30) {
                Form {
                    TextField("Username", text: $viewModel.username, prompt: Text("Username"))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $viewModel.password, prompt: Text("Password"))
                }
                Button {
                    Task {
                        if try await viewModel.signIn() {
                                loginManager.isLoggedIn.toggle()
                        } else {
                            print("alert")
                        }
                    }
                } label: {
                    Spacer()
                    Text("Sign in".uppercased())
                        .font(.system(.title2, design: .rounded ))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.orange))
                .padding([.bottom, .top], 5)
                .padding([.leading, .trailing], 30)
                Button {
                    createAnAccount.toggle()
                } label: {
                    Spacer()
                    Text("Create an accout")
                        .font(.system(.subheadline, design: .rounded ))
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                    Spacer()
                }
            }
            .sheet(isPresented: $createAnAccount) {
                CreateAccountView()
            }
            .sheet(isPresented: $signIn) {
                SignInView()
            }
        }
    }
}

struct Oups_Previews: PreviewProvider {
    static var previews: some View {
        Oups()
    }
}
