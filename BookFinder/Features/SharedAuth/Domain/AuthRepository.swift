//
//  AuthRepositoryProtocol.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 28/10/2568 BE.
//

import Foundation

protocol AuthRepository {
    func login(email: String, password: String) async -> Result<Void, AuthError>
    func register(name: String, email: String, password: String) async -> Result<Void, AuthError>
}
