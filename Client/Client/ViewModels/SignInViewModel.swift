import Foundation

final class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var hasError = false
    @Published var isSigningIn = false
    var canSignIn: Bool {
        !email.isEmpty && !password.isEmpty
    }
    func signIn() {
        guard !email.isEmpty && !password.isEmpty else {
            print("Email or password are empty")
            return
        }
        guard let url = URL(string: Request.baseURL + Endpoint.login) else {
            print("unable to create an URL to send username and password")
            return
        }
        var request = URLRequest(url: url)

        request.httpMethod = HttpMethods.POST.rawValue

        let authData = (email + ":" + password).data(using: .utf8)!.base64EncodedString()
        request.addValue("Basic \(authData)", forHTTPHeaderField: HttpHeaders.authorization.rawValue)

        isSigningIn.toggle()

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                    self?.hasError = true
                } else if let data = data {
                    do {
                        let signInResponse = try JSONDecoder().decode(SignInResponse.self, from: data)
                        print(signInResponse)
                    } catch {
                        print("Unable to Decode Response \(error.localizedDescription)")
                    }
                }
                self?.isSigningIn = false
            }
        }.resume()
    }
}

struct SignInResponse: Decodable {
    let accessToken: String
}
