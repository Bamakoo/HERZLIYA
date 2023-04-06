//
//  Keychain.swift
//  Client
//
//  Created by Emma Gaubert on 03/04/2023.
//

import Foundation
import Security

struct Keychain {
    enum KeychainError: Error {
        case noToken
        case unexpectedPasswordData
        case unhandledError(status: OSStatus)
    }
    let userToken = UserToken(value: "", id: UUID(), user: UUID())
    func addToken() {
        let account = userToken.user
        let token = userToken.value.data(using: String.Encoding.utf8)!
        var query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: account,
                                    kSecAttrServer as String: Request.baseURL,
                                    kSecValueData as String: token]
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    func search() {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrServer as String: Request.baseURL,
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true]
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.noToken }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard let existingItem = item as? [String : Any],
              let tokenData = existingItem[kSecValueData as String] as? Data,
              let token = String(data: tokenData, encoding: String.Encoding.utf8),
              let account = existingItem[kSecAttrAccount as String] as? String
        else {
            throw KeychainError.unexpectedPasswordData
        }
        let userToken = UserToken(value: "", id: UUID(), user: UUID())
    }
    func update() {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrServer as String: Request.baseURL]
        let account = userToken.user
        let token = userToken.value.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecAttrAccount as String: account,
                                         kSecValueData as String: token]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noToken }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    func delete() {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrServer as String: Request.baseURL]
        let account = userToken.user
        let token = userToken.value.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecAttrAccount as String: account,
                                         kSecValueData as String: token]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}
