//
//  KeychainHelper.swift
//  Client
//
//  Created by Emma Gaubert on 03/04/2023.
//

import Foundation
import Security

final class KeychainHelper {
    static let standard = KeychainHelper()
    private init() {}
    
    enum KeychainError: Error {
        case noPassword
        case unexpectedPasswordData
        case unexpectedItemData
        case unhandledError(status: OSStatus)
    }

    
    func create(_ data: Data, service: String, account: String) {
        // Create query
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
        ] as CFDictionary
        // Add data in query to keychain
        let status = SecItemAdd(query, nil)
        if status != errSecSuccess {
            // Print out the error
            print("Error: \(status)")
        }
        if status == errSecDuplicateItem {
            // Item already exist, thus update it.
            let query = [
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecClass: kSecClassGenericPassword,
            ] as CFDictionary
            let attributesToUpdate = [kSecValueData: data] as CFDictionary
            // Update existing item
            SecItemUpdate(query, attributesToUpdate)
        }
    }
    func update(_ data: Data, service: String, account: String) {
        // Set username and new password
        let username = "john"
        let newPassword = "5678".data(using: .utf8)!
        
        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username,
        ]
        
        // Set attributes for the new password
        let attributes: [String: Any] = [kSecValueData as String: newPassword]
        
        // Find user and update
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            print("Password has changed")
        } else {
            print("Something went wrong trying to update the password")
        }
    }
    func read(service: String, account: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }
    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        // Delete item from keychain
        SecItemDelete(query)
    }
}
