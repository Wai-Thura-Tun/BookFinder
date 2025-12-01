//
//  URLRequest.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 13/10/2568 BE.
//

import Foundation

extension URLRequest {
    mutating func useAsHeaders(_ headers: [String: String]?) {
        guard let headers = headers else { return }
        for (key, value) in headers {
            self.setValue(value, forHTTPHeaderField: key)
        }
    }
}
