import Foundation
// swiftlint:disable all
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
        @TokenRepository<String>
        var token: String?
        guard canSignIn else {
            print("Email or password are empty")
            return false
        }
        guard let url = URL(string: Request.baseURL + Endpoint.login) else {
            print("unable to create an URL to send username and password")
            return false
        }
        var request = URLRequest(url: url)
        
        request.httpMethod = HttpMethods.POST.rawValue
        
        let authData = (username + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: HttpHeaders.authorization.rawValue)
        request.addValue(MIMEType.JSON.rawValue,
                         forHTTPHeaderField: HttpHeaders.contentType.rawValue)
        isSigningIn.toggle()
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpURLResponse = response as? HTTPURLResponse else {
            throw HttpError.badResponse
        }
        if httpURLResponse.statusCode == 201 {
            print(String(data: data, encoding: .utf8))
            do {
                let decoder = JSONDecoder()
                let userToken = try decoder.decode(UserToken.self, from: data)
                print(userToken)
                token = userToken.value
                return true
            } catch {
                hasError.toggle()
                print(error.localizedDescription)
                return false
            }
        }
        else if httpURLResponse.statusCode == 401 {
            hasError.toggle()
            return false
        }
        return false 
    }
}

