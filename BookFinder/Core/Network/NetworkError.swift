//
//  NetworkError.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 15/10/2568 BE.
//

import Foundation

enum NetworkError: Error, Equatable {
    case invalidURL
    case unauthorized
    case validationErrors([String: String])
    case clientError(Int)
    case serverError(String)
    case decodeError
    case emptyResponse
    case networkError
    case invalidResponse
    case unknown
    
    var customMessage: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .unauthorized:
            return "Unable to access. Please try again"
        case .validationErrors:
            return "Validation error"
        case .serverError(let string):
            return string
        case .decodeError:
            return "Unable to parse data. Please try again later"
        case .emptyResponse:
            return "Getting empty response from server. Please try again later"
        case .networkError:
            return "Check your connection and try again."
        case .invalidResponse:
            return "Unexpected response from the server."
        case .unknown, .clientError:
            return "Something went wrong."
        }
    }
}
