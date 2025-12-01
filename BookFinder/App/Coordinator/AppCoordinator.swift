//
//  MainCoordinator.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 23/10/2568 BE.
//

import Foundation
import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    private let sessionManager: SessionManager
    
    init(
        navigationController: UINavigationController,
        sessionManager: SessionManager
    ) {
        self.navigationController = navigationController
        self.sessionManager = sessionManager
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleUserSessionExpired),
            name: .userSessionExpired,
            object: nil
        )
    }
    
    func start() {
        if !sessionManager.isAuthenticated {
            showAuthFlow()
        }
        else {
            showMainFlow()
        }
    }
    
    @objc private func handleUserSessionExpired() {
        navigationController.popToRootViewController(animated: false)
        showAuthFlow()
    }
    
    private func showAuthFlow() {
        let authCoordinator = AuthCoordinator(navigationController: navigationController)
        self.childCoordinators.append(authCoordinator)
        authCoordinator.parentCoordinator = self
        authCoordinator.start()
    }
    
    private func showMainFlow() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        self.childCoordinators.append(mainCoordinator)
        mainCoordinator.parentCoordinator = self
        mainCoordinator.start()
    }
    
    func didFinishAuthFlow(_ coordinaotr: Coordinator) {
        
        removeChildCoordinator(coordinaotr)
        
        navigationController.viewControllers = []
        
        showMainFlow()
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll { $0 === coordinator }
    }
}
