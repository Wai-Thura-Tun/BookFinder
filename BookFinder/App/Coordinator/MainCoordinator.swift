//
//  MainCoordiantor.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 7/11/2568 BE.
//

import Foundation
import UIKit

final class MainCoordinator: Coordinator {
    weak var parentCoordinator: Coordinator?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vm = Resolver.shared.resolve(BookListVM.self)
        let bookListVC = BookListVC.instantiate()
        bookListVC.configure(with: vm)
        bookListVC.coordinator = self
        self.navigationController.pushViewController(bookListVC, animated: true)
    }
}
