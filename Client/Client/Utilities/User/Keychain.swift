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
    static func addToken(userToken: UserToken) throws {
        let userID = userToken.userID
        let token = userToken.value.data(using: String.Encoding.utf8)!
        print(userID, token, userToken)
        let query = [kSecClass: kSecClassGenericPassword,
                                    kSecAttrAccount: "kireyin",
                                    kSecAttrService: "com.boox",
                                    kSecValueData: token] as CFDictionary
        print(query)
        let status = SecItemAdd(query, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        print(status)
    }
    static func search() throws -> String {
        let query = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService: "com.boox",
                                    kSecMatchLimit as String: kSecMatchLimitOne,
                                    kSecReturnAttributes as String: true,
                                    kSecReturnData as String: true] as CFDictionary
        var item: CFTypeRef?
        print(query, item)
        let status = SecItemCopyMatching(query, &item)
        print(status)
        guard status != errSecItemNotFound else { throw KeychainError.noToken }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        guard let existingItem = item as? [String: Any],
              let tokenData = existingItem[kSecValueData as String] as? Data,
              let token = String(data: tokenData, encoding: String.Encoding.utf8),
              let userID = existingItem[kSecAttrAccount as String] as? String
        else {
            throw KeychainError.unexpectedPasswordData
        }
        return token
    }
    static func update(userToken: UserToken) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrServer as String: Request.baseURL]
        let userID = userToken.userID
        let token = userToken.value.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecAttrAccount as String: userID,
                                         kSecValueData as String: token]
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noToken }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    static func delete(userToken: UserToken) throws {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrServer as String: Request.baseURL]
        let userID = userToken.userID
        let token = userToken.value.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecAttrAccount as String: userID,
                                         kSecValueData as String: token]
        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else { throw KeychainError.unhandledError(status: status) }
    }
}
