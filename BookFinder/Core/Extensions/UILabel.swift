//
//  UIApplication.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 7/11/2568 BE.
//

import Foundation
import UIKit

extension UILabel {
    func setError(text: String) {
        self.layer.opacity = 1.0
        self.text = text
    }
}
