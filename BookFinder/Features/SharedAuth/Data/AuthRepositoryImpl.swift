//
//  AuthRepository.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 14/10/2568 BE.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    
    private let network: NetworkManager
    private let keychain: KeychainManager
    
    init(network: NetworkManager, keychain: KeychainManager) {
        self.network = network
        self.keychain = keychain
    }
    
    func login(email: String, password: String) async -> Result<Void, AuthError> {
        let request = LoginRequest(email: email, password: password)
        let result: Result<LoginResponse, NetworkError> = await network.request(endpoint: .login(request), retryCount: 0)
        switch result {
        case .success(let response):
            guard let accessToken = response.accessToken, let refreshToken = response.refreshToken else {
                return .failure(.UNKNOWN("Something went wrong"))
            }
            keychain.set(key: .access_token_key, value: accessToken)
            keychain.set(key: .refresh_token_key, value: refreshToken)
            return .success(())
        case .failure(let error):
            switch error {
            case .validationErrors(let validationErrors):
                return .failure(.VALIDATION_ERROR(validationErrors))
            case .clientError(let code):
                if code == Constants.dulicateCode {
                    return .failure(.DUPLICATE_USER)
                }
                else if code == Constants.notFoundCode {
                    return .failure(.NEW_USER)
                }
                else if code == Constants.wrongCredentials {
                    return .failure(.WRONG_CREDENTIALS)
                }
                return .failure(.UNKNOWN("Something went wrong"))
            case .serverError(let message):
                return .failure(.UNKNOWN(message))
            default:
                return .failure(.UNKNOWN(error.customMessage))
            }
        }
    }
    
    func register(name: String, email: String, password: String) async -> Result<Void, AuthError> {
        // MARK: - ToDo
        return .success(())
    }
}
