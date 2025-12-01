//
//  UserDefaultManager.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 12/10/2568 BE.
//

import Foundation

extension UserDefaults {
    static let key: String = "IsOldUser"
    
    static func setUser() {
        standard.set(true, forKey: key)
    }
    
    static func getUser() -> Bool {
        standard.bool(forKey: key)
    }
}
