//
//  Alertable.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 17/11/2568 BE.
//

import Foundation
import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(title: String?, message: String?) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(alertAction)
        present(alertVC, animated: true)
    }
}
