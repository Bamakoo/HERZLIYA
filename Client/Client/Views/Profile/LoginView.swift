import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @StateObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))

    var body: some View {
        TextField(
            "User name (email address)",
            text: $username)
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .border(Color(UIColor.separator))
        SecureField(
            "Password",
            text: $password
        ) {
            viewModel.handleLogin(username: username, password: password)
        }
        .border(Color(UIColor.separator))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
