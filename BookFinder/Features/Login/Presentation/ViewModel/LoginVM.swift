//
//  LoginVM.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 12/10/2568 BE.
//

import Foundation

protocol LoginViewDelegate: AnyObject {
    func onValidate(validationErrors: [LoginVM.ValidationError])
    func onError(error: String?, validationErrors: [String: String]?)
    func onSignUpSuccess()
}

final class LoginVM {
    
    enum ValidationError {
        case EmailTextField(String)
        case PasswordTextField(String)
    }
    
    weak var delegate: LoginViewDelegate?
    
    private var loginUseCase: LoginUseCase
    
    private var loginTask: Task<Void, Error>?
    
    init(loginUseCase: LoginUseCase) {
        self.loginUseCase = loginUseCase
    }
    
    private var email: String?
    
    private var password: String?
    
    func setEmail(email: String?) {
        self.email = email
    }
    
    func setPassword(password: String?) {
        self.password = password
    }
    
    func login() {
        loginTask = Task { [weak self] in
            guard let self else { return }
            
            let result = await loginUseCase.execute(email: self.email!, password: self.password!)
            
            guard !Task.isCancelled else { return }
            
            await MainActor.run {
                handleResult(result: result)
            }
        }
    }
    
    func validateForm() {
        var errors: [ValidationError] = []
        
        if email == nil || email == "" {
            errors.append(.EmailTextField("Email is required"))
        }
        
        if password == nil || password == "" {
            errors.append(.PasswordTextField("Password is required"))
        }
        
        delegate?.onValidate(validationErrors: errors)
    }
    
    private func handleResult(result: Result<Void, AuthError>) {
        switch result {
        case .success(_):
            delegate?.onSignUpSuccess()
        case .failure(let failure):
            delegate?.onError(error: failure.message.0, validationErrors: failure.message.1)
        }
    }
    
    deinit {
        loginTask?.cancel()
        loginTask = nil
    }
}
