//
//  LoginRequest.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 13/10/2568 BE.
//

import Foundation

nonisolated
struct LoginRequest: Codable {
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email, password
    }
}
