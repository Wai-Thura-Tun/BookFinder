//
//  BookListError.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 24/11/2568 BE.
//

import Foundation

enum BookError: Error {
    case BOOKS_NOT_FOUND
    case UNKNOWN(String)
    
    var message: String {
        switch self {
        case .BOOKS_NOT_FOUND:
            "No books found."
        case .UNKNOWN(let string):
            string
        }
    }
}
