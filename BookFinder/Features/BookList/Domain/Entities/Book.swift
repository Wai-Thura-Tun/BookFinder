//
//  Book.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 22/11/2568 BE.
//

import Foundation

nonisolated
struct Book: Codable, Hashable {
    let id: Int
    let name: String?
    let overview: String?
    let type: String?
    let cover: String?
    let authorName: String?
    let categoryName: String?
    let authorBio: String?
    let rating: Int?
    let price: Double?
    let isSpecial: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, type, cover, rating, price
        case authorName = "author_name"
        case categoryName = "category_name"
        case authorBio = "author_bio"
        case isSpecial = "is_special"
    }
}
