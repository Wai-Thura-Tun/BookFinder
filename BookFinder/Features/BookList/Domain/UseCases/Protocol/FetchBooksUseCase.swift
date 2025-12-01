//
//  BookListUseCase.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 22/11/2568 BE.
//

import Foundation

protocol FetchBooksUseCase {
    func execute() async -> Result<[HomeData], BookError>
}
