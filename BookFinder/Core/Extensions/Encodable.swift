//
//  Encodable.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 13/10/2568 BE.
//

import Foundation

extension Encodable {
    nonisolated
    func toData() -> Data? {
        try? JSONEncoder().encode(self)
    }
}
