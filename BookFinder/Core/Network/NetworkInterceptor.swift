//
//  NetworkInterceptorProtocol.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 30/10/2568 BE.
//

import Foundation

protocol NetworkInterceptor: Sendable {
    func intercept(_ request: URLRequest, endpoint: BookFinderEndpoint) async -> URLRequest
    func handleUnauthorized() async throws
}
