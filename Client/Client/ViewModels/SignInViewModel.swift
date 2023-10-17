import Foundation
@MainActor final class SignInViewModel: ObservableObject {

    @Published var username = String()
    @Published var password = String()
    @Published var hasError = false
    @Published var isSigningIn = false

    var canSignIn: Bool {
        !username.isEmpty && !password.isEmpty
    }

    func signIn() async throws -> Bool {
        do {
            guard canSignIn else {
                return false
            }
            try await UseCase.User.login(username, password)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
}
