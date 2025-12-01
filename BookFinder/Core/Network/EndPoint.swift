//
//  EndPoint.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 13/10/2568 BE.
//

import Foundation
import UIKit
internal import UniformTypeIdentifiers

protocol EndPoint: Sendable {
    nonisolated var baseURL: URL { get }
    nonisolated var method: String { get }
    nonisolated var path: String { get }
    nonisolated var headers: [String: String]? { get }
    nonisolated var parameter: Data? { get }
}

extension EndPoint {
    nonisolated var baseURL: URL {
        let baseURLString = Bundle.main.object(forInfoDictionaryKey: "API_BASE_URL") as! String
        return URL(string: baseURLString)!
    }
    
    nonisolated func asURL() -> URL {
        if #available(iOS 16.0, *) {
            return self.baseURL.appending(path: self.path)
        }
        else {
            return self.baseURL.appendingPathComponent(self.path)
        }
        
    }
}
