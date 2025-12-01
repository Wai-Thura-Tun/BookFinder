//
//  KeychainManager.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 12/10/2568 BE.
//

import Foundation
import KeychainAccess

final class KeychainManagerImpl: KeychainManager {
    
    private let keychain: Keychain
    
    init() {
        self.keychain = Keychain(service: "com.bookfinder.keychain")
    }
    
    func set(key: KeychainKeys, value: String) {
        self.keychain[key.rawValue] = value
    }
    
    func get(key: KeychainKeys) -> String? {
        return self.keychain[key.rawValue]
    }
    
    func delete(key: KeychainKeys) {
        self.keychain[key.rawValue] = nil
    }
    
    func deleteAll() {
        self.keychain[KeychainKeys.access_token_key.rawValue] = nil
        self.keychain[KeychainKeys.refresh_token_key.rawValue] = nil
    }
}

