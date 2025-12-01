//
//  AuthCoordinator.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 7/11/2568 BE.
//

import Foundation
import UIKit

final class AuthCoordinator: Coordinator {
    weak var parentCoordinator: AppCoordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.showLogin()
    }
    
    func showRegister() {
        let registerVC = RegisterVC.instantiate()
        registerVC.coordinator = self
        self.navigationController.pushViewController(registerVC, animated: true)
    }
    
    func showLogin() {
        let vm = Resolver.shared.resolve(LoginVM.self)
        let loginVC = LoginVC.instantiate()
        loginVC.configure(with: vm)
        loginVC.coordinator = self
        self.navigationController.pushViewController(loginVC, animated: true)
    }
    
    func backToLogin() {
        self.navigationController.popViewController(animated: true)
    }
    
    func didFinishLogin() {
        parentCoordinator?.didFinishAuthFlow(self)
    }
    
    
}
