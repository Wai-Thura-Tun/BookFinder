//
//  FetchBooksUseCaseImpl.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 22/11/2568 BE.
//

import Foundation

final class FetchBooksUseCaseImpl: FetchBooksUseCase {
    
    private let bookRepository: BookRepository
    
    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }
    
    func execute() async -> Result<[HomeData], BookError>{
        let response = await bookRepository.fetchBooks()
        switch response {
        case .success(let response):
            var books: [HomeData] = []
            
            if let specialBooks = response.data?.specialBooks {
                let specialItem = SpecialBook(books: specialBooks)
                books.append(.specialBook(specialItem))
            }
            
            if let normalBooks = response.data?.normalBooks {
                let normalItems = normalBooks.map { HomeData.normalBook($0) }
                books.append(contentsOf: normalItems)
            }
            
            return .success(books)
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
