//
//  Coordinator.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 25/10/2568 BE.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
