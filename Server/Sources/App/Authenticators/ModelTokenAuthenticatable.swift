import Vapor
import Fluent

extension UserToken: ModelTokenAuthenticatable {
    static let valueKey = \UserToken.$value
    static let userKey = \UserToken.$user

    var isValid: Bool {
        true
        // TODO: token for user A cannot be used to change profile for User B
        // TODO: give token a lifetime value of 24 hours
    }
}
