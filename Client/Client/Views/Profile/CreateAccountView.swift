import SwiftUI

struct CreateAccountView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var favoriteBook = ""
    @State private var favoriteAuthor = ""
    @State private var city = ""
    @State private var country = ""
    
    @StateObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    
    var body: some View {
        Form {
            TextField("Username", text: $username, prompt: Text("Username"))
            TextField("Email", text: $email, prompt: Text("Email address"))
            TextField("Password", text: $password, prompt: Text("Password"))
            TextField("Confirm Password", text: $confirmPassword, prompt: Text("Confirm Password"))
            Text("We'll use your favorite author and book as an extra security layer")
            TextField("Favorite Book", text: $favoriteBook, prompt: Text("Favorite Book"))
            TextField("Favorite Author", text: $favoriteAuthor, prompt: Text("Favorite Author"))
            TextField("City", text: $city, prompt: Text("City where you're currently located"))
            TextField("Country", text: $country, prompt: Text("Country where you're currently located"))
        }
        Button {
            Task {
                try await viewModel.createANewUser(username: username, email: email, password: password, confirmPassword: confirmPassword, favoriteBook: favoriteBook, favoriteAuthor: favoriteAuthor, city: city, country: country)
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
