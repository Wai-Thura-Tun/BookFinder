//
//  LoginVC.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 23/10/2568 BE.
//

import UIKit

class LoginVC: UIViewController, Storyboarded, Alertable {
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    weak var coordinator: AuthCoordinator?
    
    private var vm: LoginVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(vm != nil, "LoginVM must be configured before viewDidLoad")
        
        self.setUpViews()
        self.setUpBindings()
    }

    private func setUpViews() {
        self.lblEmailError.layer.opacity = 0
        self.lblPasswordError.layer.opacity = 0
    }
    
    private func setUpBindings() {
        tfEmail.addTarget(self, action: #selector(onChangeEmail), for: .editingChanged)
        tfPassword.addTarget(self, action: #selector(onChangePassword), for: .editingChanged)
        btnLogin.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        btnRegister.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
    }
    
    func configure(with vm: LoginVM) {
        self.vm = vm
        self.vm.delegate = self
    }
    
    @objc private func onTapLogin() {
        self.vm.validateForm()
    }
    
    @objc private func onTapRegister() {
        self.coordinator?.showRegister()
    }
    
    @objc private func onChangeEmail() {
        self.vm.setEmail(email: tfEmail.text)
    }
    
    @objc private func onChangePassword() {
        self.vm.setPassword(password: tfPassword.text)
    }
    
    private func clearError() {
        self.lblEmailError.text = ""
        self.lblPasswordError.text = ""

    }
}

extension LoginVC: LoginViewDelegate {
    func onValidate(validationErrors: [LoginVM.ValidationError]) {
        clearError()
        if validationErrors.isEmpty {
            self.vm.login()
        }
        else {
            validationErrors.forEach { validationError in
                switch validationError {
                case .EmailTextField(let message):
                    lblEmailError.setError(text: message)
                case .PasswordTextField(let message):
                    lblPasswordError.setError(text: message)
                }
            }
        }
    }
    
    func onError(error: String?, validationErrors: [String : String]?) {
        if let error = error {
            showAlert(title: nil, message: error)
        }
        
        if let validationErrors = validationErrors {
            if let emailError = validationErrors["email"] {
                lblEmailError.setError(text: emailError)
            }
            
            if let passwordError = validationErrors["password"] {
                lblPasswordError.setError(text: passwordError)
            }
        }
    }
    
    func onSignUpSuccess() {
        self.coordinator?.didFinishLogin()
    }
}
