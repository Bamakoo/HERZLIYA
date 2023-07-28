//
//  TokenRepository.swift
//  Client
//
//  Created by Emma Gaubert on 06/07/2023.
//

import Foundation

@propertyWrapper
struct TokenRepository<Value> {
    let account: String = "user"
    let service: String = "token"

    var wrappedValue: String? {
        get {
            try? Keychain.getGenericPasswordForAccount(account, service: service)
        } set {
            guard let newValue else {
                try? Keychain.deleteGenericPasswordForAccount(account, service: service)
                return
            }
            do {
                try Keychain.addGenericPasswordForAccount(account, password: newValue, service: service)
            } catch KeychainError.duplicateItem {
                try? Keychain.updateGenericPasswordForAccount(account, password: newValue, service: service)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
