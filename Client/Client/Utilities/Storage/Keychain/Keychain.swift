//
//  Keychain.swift
//  Client
//
//  Created by Emma Gaubert on 03/04/2023.
//

import Foundation
import Security

enum KeychainError: Error {
    case noToken
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
    case duplicateItem
}

struct Keychain {

    static func addGenericPasswordForAccount(_ account: String, password: String, service: String) throws {
        let data = password.data(using: String.Encoding.utf8)!
        let query = [kSecClass: kSecClassGenericPassword,
               kSecAttrAccount: account,
               kSecAttrService: service,
                 kSecValueData: data] as CFDictionary
        let status = SecItemAdd(query, nil)
        if status == errSecDuplicateItem {
            throw KeychainError.duplicateItem
        }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        print(status)
    }

    static func getGenericPasswordForAccount(_ account: String, service: String) throws -> String {
        let query = [kSecClass as String: kSecClassGenericPassword,
                         kSecAttrService: service,
                         kSecAttrAccount: account,
                     kSecReturnAttributes as String: true,
                     kSecReturnData as String: true] as CFDictionary
        var item: CFTypeRef?
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

    static func updateGenericPasswordForAccount(_ account: String, password: String, service: String) throws {
        let query = [kSecClass as String: kSecClassGenericPassword,
                         kSecAttrService: service,
                         kSecAttrAccount: account ] as CFDictionary

        let data = password.data(using: String.Encoding.utf8)!
        let attributes: [String: Any] = [kSecValueData as String: data]

        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else { throw KeychainError.noToken }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }

    static func deleteGenericPasswordForAccount(_ account: String, service: String) throws {
        let query = [kSecClass as String: kSecClassGenericPassword,
                         kSecAttrService: service,
                         kSecAttrAccount: account ] as CFDictionary

        let status = SecItemDelete(query as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound
        else { throw KeychainError.unhandledError(status: status) }
    }
}
