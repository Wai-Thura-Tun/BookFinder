//
//  LoginResponse.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 13/10/2568 BE.
//

import Foundation

nonisolated
struct LoginResponse: Codable {
    let message: String?
    let accessToken: String?
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case message
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

typealias RefreshResponse = LoginResponse
