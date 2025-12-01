//
//  KeychainManagerProtocol.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 30/10/2568 BE.
//

import Foundation

protocol KeychainManager: Sendable {
    func set(key: KeychainKeys, value: String)
    func get(key: KeychainKeys) -> String?
    func delete(key: KeychainKeys)
    func deleteAll()
}
