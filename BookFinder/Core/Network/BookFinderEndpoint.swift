//
//  BookFinderEndpoint.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 13/10/2568 BE.
//

import Foundation

nonisolated
enum BookFinderEndpoint: EndPoint {
    case login(any Encodable & Sendable)
    case register(any Encodable & Sendable)
    case refresh(String)
    case getBooks
    
    var method: String {
        switch self {
        case .login, .register, .refresh:
            return "POST"
        case .getBooks:
            return "GET"
        }
    }
    
    var path: String {
        switch self {
        case .login:
            return "/auth/login"
        case .register:
            return "/auth/register"
        case .refresh:
            return "/auth/refresh"
        case .getBooks:
            return "/book/list"
        }
    }
    
    var requiresAuth: Bool {
        switch self {
        case .login, .register:
            return false
        default:
            return true
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login, .register, .getBooks, .refresh:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameter: Data? {
        switch self {
        case .login(let request), .register(let request):
            return request.toData()
        case .refresh(let refreshToken):
            let body: [String: String] = ["refresh_token": refreshToken]
            return body.toData()
        case .getBooks:
            return nil
        }
    }
}
