//
//  BookListVM.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 22/11/2568 BE.
//

import Foundation

protocol BookListViewDelegate: AnyObject {
    func onLoadBooksSuccess()
    func onError(error message: String)
}

final class BookListVM {
    
    private let fetchBooksUseCase: FetchBooksUseCase
    private let searchBooksUseCase: SearchBooksUseCase
    
    private(set) var books: [HomeData] = []
    
    weak var delegate: BookListViewDelegate?
    
    private var bookTasks: Task<Void, Error>?
    
    init(fetchBooksUseCase: FetchBooksUseCase, searchBooksUseCase: SearchBooksUseCase) {
        self.fetchBooksUseCase = fetchBooksUseCase
        self.searchBooksUseCase = searchBooksUseCase
    }
    
    func getBooks() {
        bookTasks = Task { @MainActor [weak self] in
            guard let self = self, !Task.isCancelled else { return }
            
            let result = await self.fetchBooksUseCase.execute()
            
            if !Task.isCancelled {
                let books = try? result.get()
                self.books = books ?? []
                self.delegate?.onLoadBooksSuccess()
            }
        }
    }
    
    deinit {
        bookTasks?.cancel()
        bookTasks = nil
    }
}
