//
//  BookListRepositoryImpl.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 24/11/2568 BE.
//

import Foundation

final class BookRepositoryImpl: BookRepository {
    
    private let network: NetworkManager
    
    init(network: NetworkManager) {
        self.network = network
    }
    
    func fetchBooks() async -> Result<BookListResponse, BookError> {
        let response: Result<BookListResponse, NetworkError> = await network.request(
            endpoint: .getBooks,
            retryCount: 0
        )
        
        switch response {
        case .success(let bookListResponse):
            return .success(bookListResponse)
        case .failure(let error):
            switch error {
            case .clientError(let code):
                if code == 404 {
                    return .failure(.BOOKS_NOT_FOUND)
                }
                return .failure(.UNKNOWN("Something went wrong"))
            case .serverError(let message):
                return .failure(.UNKNOWN(message))
            default:
                return .failure(.UNKNOWN(error.customMessage))
            }
        }
    }
}
