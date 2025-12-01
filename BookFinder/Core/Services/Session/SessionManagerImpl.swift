//
//  SessionManager.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 25/10/2568 BE.
//

import Foundation

final class SessionManagerImpl: SessionManager {
    
    private let keychainManager: KeychainManager
    
    init(keychainManager: KeychainManager) {
        self.keychainManager = keychainManager
    }
    
    var isAuthenticated: Bool {
        guard let accessToken = keychainManager.get(key: .access_token_key), !accessToken.isEmpty else {
            return false
        }
        return true
    }
    
    func login(accessToken: String, refreshToken: String) {
        keychainManager.set(key: .access_token_key, value: accessToken)
        keychainManager.set(key: .refresh_token_key, value: refreshToken)
    }
    
    func logout() {
        keychainManager.deleteAll()
    }
    
    func handleSessionExpiration() {
        logout()
        
        NotificationCenter.default.post(name: .userSessionExpired, object: nil)
    }
}
