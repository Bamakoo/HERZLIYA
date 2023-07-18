// swiftlint:disable all

import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel = SignInViewModel()
    @State private var forgotMyPassword = false
    @State private var createAnAccount = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Form {
            TextField("Username", text: $viewModel.username, prompt: Text("Username"))
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
            SecureField("Password", text: $viewModel.password, prompt: Text("Password"))
            Button("Sign In") {
                Task {
                    if try await viewModel.signIn() {
                        DispatchQueue.main.async {
                            dismiss()
                        }
                    }
                    else {
                        print("alert")
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            Button("Create an account"){
                createAnAccount.toggle()
            }
            Button("Forgot my password"){
                forgotMyPassword.toggle()
            }
        }
        .sheet(isPresented: $forgotMyPassword) {
            ForgotMyPasswordView()
        }
        .sheet(isPresented: $createAnAccount) {
            CreateAccountView()
        }
        .textFieldStyle(.roundedBorder)
        .disabled(viewModel.isSigningIn)
        .alert(isPresented: $viewModel.hasError) {
            Alert(
                title: Text("Sign In Failed"),
                message: Text("The email/password combination is invalid.")
            )
        }
    }
}
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(viewModel: SignInViewModel())
    }
}
