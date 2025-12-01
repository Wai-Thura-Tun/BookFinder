//
//  SessionManagerProtocol.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 30/10/2568 BE.
//

import Foundation

protocol SessionManager: Sendable {
    var isAuthenticated: Bool { get }
    func login(accessToken: String, refreshToken: String)
    func logout()
    func handleSessionExpiration()
}
