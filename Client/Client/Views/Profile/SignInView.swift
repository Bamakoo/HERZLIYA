// swiftlint:disable all
// TODO: 
// transform into Form
// login, create my account, forgot my password
import SwiftUI

struct SignInView: View {
    
    @ObservedObject var viewModel: SignInViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                VStack(alignment: .leading) {
                    TextField("Username", text: $viewModel.username, prompt: Text("Username"))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $viewModel.password, prompt: Text("Password"))
                }
                .textFieldStyle(.roundedBorder)
                .disabled(viewModel.isSigningIn)
                if viewModel.isSigningIn {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else {
                    Button("Sign In") {
                        viewModel.signIn()
                    }
                }
                Spacer()
            }
            .padding()
            .frame(maxWidth: 400.0)
            Spacer()
        }
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
