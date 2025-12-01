//
//  HomeData.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 29/11/2568 BE.
//

import Foundation

nonisolated
enum HomeData: Hashable {
    case normalBook(Book)
    case specialBook(SpecialBook)
}

nonisolated
struct SpecialBook: Hashable {
    let books: [Book]
    
    init(books: [Book]) {
        self.books = books
    }
}
