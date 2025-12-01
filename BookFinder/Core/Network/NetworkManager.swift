//
//  NetworkManagerProtocol.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 30/10/2568 BE.
//

import Foundation

protocol NetworkManager {
    func request<T: Codable>(endpoint: BookFinderEndpoint, retryCount: Int) async -> Result<T, NetworkError> where T: Sendable
}
