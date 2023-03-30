import Vapor

extension Book: Validatable {
    static func validations(_ validations: inout Validations) {
        validations.add("title", as: String.self, is: !.empty)
        validations.add("author", as: String.self, is: !.empty)
        validations.add("description", as: String.self, is: !.empty)
        validations.add("price", as: Int.self, is: .range(1...))
    }
}
