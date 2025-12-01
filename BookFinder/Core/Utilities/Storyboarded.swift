//
//  Storyboarded.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 11/10/2568 BE.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate(bundle: Bundle) -> Self
}

extension Storyboarded {
    static func instantiate(bundle: Bundle = Bundle.main) -> Self {
        let identifier: String =  String(describing: Self.self)
        let storyboardName = identifier.replacingOccurrences(of: "VC", with: "Storyboard")
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(identifier: String(describing: Self.self)) as! Self
    }
}
