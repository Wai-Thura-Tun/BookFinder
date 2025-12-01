//
//  BookListResponse.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 22/11/2568 BE.
//

import Foundation

nonisolated
struct BookListResponse: Codable {
    let data: BookResponse?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}

nonisolated
struct BookResponse: Codable, Hashable {
    let specialBooks: [Book]?
    let normalBooks: [Book]?
    
    enum CodingKeys: String, CodingKey {
        case specialBooks = "special_books"
        case normalBooks = "normal_books"
    }
}
