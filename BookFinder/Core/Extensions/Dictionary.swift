//
//  Dictionary.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 26/10/2568 BE.
//

import Foundation

extension Dictionary {
    nonisolated
    func toData() -> Data? {
        try? JSONSerialization.data(withJSONObject: self)
    }
}
