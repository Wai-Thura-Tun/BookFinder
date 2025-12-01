//
//  NetworkManager.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 13/10/2568 BE.
//

import Foundation

final actor NetworkManagerImpl: NetworkManager {
    
    private let maxRetryAttempt: Int = 1
    private let requestTimeout: TimeInterval = 30
    private let interceptor: NetworkInterceptor
    
    init(interceptor: NetworkInterceptor) {
        self.interceptor = interceptor
    }
    
    func request<T: Codable>(endpoint: BookFinderEndpoint, retryCount: Int = 0) async -> Result<T, NetworkError> where T: Sendable {
        
        do {
            let request = await buildRequest(endpoint)
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }
            
            if data.isEmpty {
                throw NetworkError.emptyResponse
            }
            
            return await handleResponse(
                data: data,
                statusCode: httpResponse.statusCode,
                retryCount: retryCount,
                endpoint: endpoint
            )
            
        }
        catch let error as NetworkError {
            return .failure(error)
        }
        catch {
            return .failure(.unknown)
        }
        
    }
    
    private func buildRequest(_ endpoint: BookFinderEndpoint) async -> URLRequest {
        var request = URLRequest(url: endpoint.asURL())
        request.httpMethod = endpoint.method
        request.httpBody = endpoint.parameter
        await request.useAsHeaders(endpoint.headers)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        await request.useAsHeaders(endpoint.headers)
        return await interceptor.intercept(request, endpoint: endpoint)
    }
    
    private func handleResponse<T: Codable & Sendable>(
        data: Data,
        statusCode: Int,
        retryCount: Int,
        endpoint: BookFinderEndpoint
    ) async -> Result<T, NetworkError> {
        switch statusCode {
        case 401:
            return await handleUnauthorized(
                retryCount: retryCount,
                endpoint: endpoint
            )
        case 200..<300:
            return decodeSuccess(data)
        case 400..<500:
            return decodeClientError(data, statusCode: statusCode)
        case 500..<600:
            return decodeServerError(data)
        default:
            return .failure(.unknown)
        }
    }
    
    private func handleUnauthorized<T: Codable & Sendable>(
        retryCount: Int,
        endpoint: BookFinderEndpoint
    ) async -> Result<T, NetworkError> {
        
        if case .login = endpoint {
            return .failure(.clientError(401))
        }
        
        // Already retried
        guard retryCount < maxRetryAttempt else {
            return .failure(.unauthorized)
        }
        
        if case .refresh = endpoint {
            return .failure(.invalidURL)
        }
        
        // Try refreshing token
        do {
            try await interceptor.handleUnauthorized()
            
            #if DEBUG
            print("Token refreshed")
            #endif
            
            return await self.request(endpoint: endpoint, retryCount: retryCount + 1)
        }
        catch let error as NetworkError {
            return .failure(error)
        }
        catch {
            return .failure(.unknown)
        }
    }
    
    private func decodeClientError<T: Codable & Sendable>(
        _ data: Data,
        statusCode: Int
    ) -> Result<T, NetworkError> {
        if let response = try? JSONDecoder().decode(ErrorResponse.self, from: data), let validationErrors = response.validationErrors {
            return .failure(.validationErrors(validationErrors))
        }
        return .failure(.clientError(statusCode))
    }
    
    private func decodeServerError<T: Codable & Sendable>(_ data: Data) -> Result<T, NetworkError> {
        if let response = try? JSONDecoder().decode(ErrorResponse.self, from: data), let errorMessage = response.error {
            return .failure(.serverError(errorMessage))
        }
        return .failure(.serverError("Something went wrong"))
    }
    
    private func decodeSuccess<T: Codable & Sendable>(_ data: Data) -> Result<T, NetworkError> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        }
        catch {
            return .failure(.decodeError)
        }
        
    }
}
