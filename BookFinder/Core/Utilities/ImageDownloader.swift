//
//  ImageDownloader.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 24/11/2568 BE.
//

import Foundation
import UIKit

protocol ImageDownloader {
    func image(for urlString: String) async throws -> UIImage?
}

actor ImageDownloaderImpl: ImageDownloader {
    
    private enum CacheEntry {
        case inProgress(Task<UIImage, Error>)
        case ready(UIImage)
    }
    
    private var caches:[URL: CacheEntry] = [:]
    
    func image(for urlString: String) async throws -> UIImage? {
        guard let url = URL(string: urlString) else { return nil }
        
        if let cached = caches[url] {
            switch cached {
            case .inProgress(let task):
                return try await task.value
            case .ready(let image):
                return image
            }
        }
        
        let task = Task {
            try await downloadImage(from: url)
        }
        
        caches[url] = .inProgress(task)
        
        do {
            let image = try await task.value
            caches[url] = .ready(image)
            return image
        }
        catch {
            caches[url] = nil
            throw error
        }
    }
    
    private func downloadImage(from url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let image = UIImage(data: data) else {
            throw URLError(.badServerResponse)
        }
        return image
    }
}
