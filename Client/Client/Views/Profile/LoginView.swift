import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    
    @StateObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    
    
    var body: some View {
        TextField(text: $username, prompt: Text("Username")) {
            Text("Username")
        }
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .border(Color(UIColor.separator))
        SecureField(text: $username, prompt: Text("Password")) {
            Text("Password")
        }
        Button {
            viewModel.handleLogin(username: username, password: password)
        } label: {
            Text("Connect")
        }
        NavigationLink(destination: CreateAccountView()) {
            Text("Create an account")
        }
        .border(Color(UIColor.separator))
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
