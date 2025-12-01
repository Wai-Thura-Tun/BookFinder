//
//  RegisterVC.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 24/10/2568 BE.
//

import UIKit

class RegisterVC: UIViewController, Storyboarded {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    weak var coordinator: AuthCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpViews()
        setUpBindings()
    }
    
    private func setUpViews() {
        self.coordinator?.navigationController.navigationBar.isHidden = true
        self.lblNameError.layer.opacity = 0
        self.lblEmailError.layer.opacity = 0
        self.lblPasswordError.layer.opacity = 0
    }
    
    private func setUpBindings() {
        btnRegister.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        btnLogin.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
    }

    @objc private func onTapRegister() {
        //
    }
    
    @objc private func onTapLogin() {
        coordinator?.backToLogin()
    }
}
