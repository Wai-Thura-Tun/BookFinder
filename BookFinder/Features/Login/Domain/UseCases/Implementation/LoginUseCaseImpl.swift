//
//  LoginUseCase.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 28/10/2568 BE.
//

import Foundation

final class LoginUseCaseImpl: LoginUseCase {
    
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute(email: String, password: String) async -> Result<Void, AuthError> {
        guard !email.isEmpty else {
            return .failure(.VALIDATION_ERROR(["email": "Email is required."]))
        }
        
        guard email.isEmail else {
            return .failure(.VALIDATION_ERROR(["email": "Email is invalid."]))
        }
        
        guard !password.isEmpty else {
            return .failure(.VALIDATION_ERROR(["password": "Password is required."]))
        }
        
        return await authRepository.login(email: email, password: password)
    }
}
