//
//  NetworkInterceptor.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 13/10/2568 BE.
//

import Foundation
import UIKit

final actor NetworkInterceptorImpl: NetworkInterceptor {
    
    private let keychainManager: KeychainManager
    private let sessionManager: SessionManager
    private var ongoingRefreshTask: Task<Void, Error>?
    
    init(keychainManager: KeychainManager, sessionManager: SessionManager) {
        self.keychainManager = keychainManager
        self.sessionManager = sessionManager
    }
    
    func intercept(_ request: URLRequest, endpoint: BookFinderEndpoint) async -> URLRequest {
        var req = request
        if endpoint.requiresAuth {
            if let accessToken = await keychainManager.get(key: .access_token_key) {
                req.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
        }
        return req
    }
    
    func handleUnauthorized() async throws {
        if let task = ongoingRefreshTask {
            #if DEBUG
            print("Waiting for existing refresh task to finish ....")
            #endif
            return try await task.value
        }
        else {
            ongoingRefreshTask = Task {
                defer { ongoingRefreshTask = nil }
                do {
                    try await performTokenRefresh()
                    ongoingRefreshTask = nil
                    #if DEBUG
                    print("Token refresh successful")
                    #endif
                    return
                }
                catch {
                    ongoingRefreshTask = nil
                    #if DEBUG
                    print("Token refresh failed: \(error)")
                    #endif
                    throw error
                }
            }
            return try await ongoingRefreshTask!.value
        }
    }
    
    private func performTokenRefresh() async throws {
        guard let refreshToken = await keychainManager.get(key: .refresh_token_key) else { throw NetworkError.unauthorized }
        
        let endPoint = BookFinderEndpoint.refresh(refreshToken)
        
        var request = URLRequest(url: endPoint.asURL())
        request.httpMethod = "POST"
        await request.useAsHeaders(endPoint.headers)
        request.httpBody = endPoint.parameter
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let response = response as? HTTPURLResponse else { throw NetworkError.invalidResponse }
            
            if data.isEmpty {
                throw NetworkError.emptyResponse
            }
            
            try await handleResponse(statusCode: response.statusCode, data: data)
        }
        catch _ as DecodingError {
            throw NetworkError.decodeError
        }
        catch {
            #if DEBUG
            print("Performing token refresh: \(error.localizedDescription)")
            #endif
            throw NetworkError.unknown
        }
       
    }
    
    private func handleResponse(statusCode: Int, data: Data) async throws {
        switch statusCode {
        case 200:
            let refreshResponse = try JSONDecoder().decode(RefreshResponse.self, from: data)
            
            guard let accessToken = refreshResponse.accessToken, let refreshToken = refreshResponse.refreshToken else { throw NetworkError.unauthorized }
            
            await sessionManager.login(accessToken: accessToken, refreshToken: refreshToken)
        case 401:
            await sessionManager.handleSessionExpiration()
        case 400..<500:
            guard let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) else { throw NetworkError.clientError(statusCode) }
            if let validationErrors = errorResponse.validationErrors {
                throw NetworkError.validationErrors(validationErrors)
            }
            throw NetworkError.clientError(statusCode)
        case 500..<600:
            guard let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) else { throw NetworkError.serverError("Something went wrong") }
            throw NetworkError.serverError(errorResponse.error ?? "Something went wrong")
        default:
            throw NetworkError.unknown
        }
    }
    
    deinit {
        ongoingRefreshTask?.cancel()
        ongoingRefreshTask = nil
    }
}
