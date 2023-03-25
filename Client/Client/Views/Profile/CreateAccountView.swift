import SwiftUI

struct CreateAccountView: View {
    @State private var city = ""
    @State private var country = ""
    @State private var password = ""
    @State private var favoriteAuthor = ""
    @State private var favoriteBook = ""
    @State private var username = ""
    @State private var email = ""
    
    @StateObject private var viewModel = UsersViewModel(networkManager: UserNetworkManager(httpClient: Networking()))
    var body: some View {
        Text("We'll use your favorite author and book as an extra security layer")
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
