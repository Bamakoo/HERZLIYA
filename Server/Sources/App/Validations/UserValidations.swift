import Vapor

extension User.Create: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("username", as: String.self, is: !.empty)
        validations.add("username", as: String.self, is: .count(3...) && .alphanumeric)
        validations.add("email", as: String.self, is: !.empty && .email)
        validations.add("city", as: String.self, is: .count(2...) && .alphanumeric)
        validations.add("country", as: String.self, is: .count(2...) && .alphanumeric)
    }
}
