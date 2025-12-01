//
//  AuthError.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 1/11/2568 BE.
//

import Foundation

enum AuthError: Error {
    case NEW_USER
    case DUPLICATE_USER
    case WRONG_CREDENTIALS
    case VALIDATION_ERROR([String: String])
    case UNKNOWN(String)
    
    var message: (String?, [String: String]?) {
        switch self {
        case .NEW_USER:
            return ("Your email is not registered yet.", nil)
        case .DUPLICATE_USER:
            return ("Your email is already registered.", nil)
        case .WRONG_CREDENTIALS:
            return ("Password is wrong", nil)
        case .VALIDATION_ERROR(let dicts):
            return (nil, dicts)
        case .UNKNOWN(let string):
            return (string, nil)
        }
    }
}
                    
