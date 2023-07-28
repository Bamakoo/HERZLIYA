import Foundation
final class SignInViewModel: ObservableObject {
    @Published var username = ""
    @Published var password = ""
    @Published var hasError = false
    @Published var isSigningIn = false
    var canSignIn: Bool {
        !username.isEmpty && !password.isEmpty
    }
    @MainActor
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
