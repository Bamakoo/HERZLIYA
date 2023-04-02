import SwiftUI

struct CreateAccountView: View {
    @ObservedObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    var body: some View {
        Form {
            Section("Username & email") {
                TextField("Username", text: $viewModel.username, prompt: Text("Username"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                TextField("Email", text: $viewModel.email, prompt: Text("Email address"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            Section("Password") {
                SecureField("Password", text: $viewModel.password, prompt: Text("Password"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                SecureField("Confirm Password", text: $viewModel.confirmPassword, prompt: Text("Confirm Password"))
            }
            Section("Favorite Book & Author") {
                Text("We'll use your favorite author and book as an extra security layer")
                TextField("Favorite Book", text: $viewModel.favoriteBook, prompt: Text("Favorite Book"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                TextField("Favorite Author", text: $viewModel.favoriteAuthor, prompt: Text("Favorite Author"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            Section("Location") {
                TextField("City", text: $viewModel.city, prompt: Text("City where you're currently located"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                TextField("Country", text: $viewModel.country, prompt: Text("Country where you're currently located"))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            Button {
                Task {
                    try await viewModel.createANewUser()
                }
            } label: {
                Text("Create Account")
            }
        }
    }
}
struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
