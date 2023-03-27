import SwiftUI

struct CreateAccountView: View {
    
    @ObservedObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    
    var body: some View {
        TextField("Username", text: $viewModel.username, prompt: Text("Username"))
        TextField("Email", text: $viewModel.email, prompt: Text("Email address"))
        TextField("Password", text: $viewModel.password, prompt: Text("Password"))
        TextField("Confirm Password", text: $viewModel.confirmPassword, prompt: Text("Confirm Password"))
        Text("We'll use your favorite author and book as an extra security layer")
        TextField("Favorite Book", text: $viewModel.favoriteBook, prompt: Text("Favorite Book"))
        TextField("Favorite Author", text: $viewModel.favoriteAuthor, prompt: Text("Favorite Author"))
        TextField("City", text: $viewModel.city, prompt: Text("City where you're currently located"))
        TextField("Country", text: $viewModel.country, prompt: Text("Country where you're currently located"))
        Button {
            Task {
                try await viewModel.createANewUser()
            }
        } label: {
            Text("create my account")
        }
    }
}


struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
