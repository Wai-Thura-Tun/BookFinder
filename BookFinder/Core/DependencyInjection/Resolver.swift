//
//  Resolver.swift
//  BookFinder
//
//  Created by Wai Thura Tun on 25/10/2568 BE.
//

import Foundation

final class Resolver {
    
    enum LifeSpan {
        case transient
        case singleton
    }
    
    static let shared: Resolver = .init()
    
    private var factories: [String: () -> Any] = [:]
    private var singletons: [String: Any] = [:]
    
    private init() {}
    
    func register<T>(
        _ type: T.Type,
        _ lifetime: LifeSpan = .transient,
        factory: @escaping () -> T
    ) {
        let key: String = String(describing: type)
        
        switch lifetime {
        case .singleton:
            self.singletons[key] = factory()
        case .transient:
            self.factories[key] = factory
        }
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        
        if let shared = singletons[key] as? T {
            return shared
        }
        
        guard let factory = self.factories[key] else { fatalError("No registration for \(key)") }
        return factory() as! T
    }
}

