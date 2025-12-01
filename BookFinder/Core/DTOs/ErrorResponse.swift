//
//  ErrorResponse.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 1/11/2568 BE.
//

import Foundation

nonisolated
struct ErrorResponse: Decodable {
    let error: String?
    let validationErrors: [String: String]?
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case error, detail
        case validationErrors = "validation_errors"
    }
}

