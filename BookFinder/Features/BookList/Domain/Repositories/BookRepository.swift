//
//  BookListRepository.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 24/11/2568 BE.
//

import Foundation

protocol BookRepository {
    func fetchBooks() async -> Result<BookListResponse, BookError>
}
