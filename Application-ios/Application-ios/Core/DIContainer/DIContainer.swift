//
//  DIContainer.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation

final class DIContainer {
    
    static let shared = DIContainer()
    
    private var services: [String: Any] = [:]
    
    private init() {
        // TODO
    }
    
    func register<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        services[key] = instance
    }
    
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        services[key] = factory
    }
    
    func register<T, Arg>(_ type: T.Type, factory: @escaping (Arg) -> T) {
        let key = String(describing: type)
        services[key] = factory
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        
        if let service = services[key] as? T {
            return service
        }
        
        if let factory = services[key] as? () -> T {
            let instance = factory()
            services[key] = instance
            return instance
        }
        
        fatalError("❌ Service \(type) is not registered in DIContainer")
    }
    
    func resolve<T, Arg>(_ type: T.Type, argument: Arg) -> T {
        let key = String(describing: type)
        
        if let factory = services[key] as? (Arg) -> T {
            return factory(argument)
        }
        
        fatalError("❌ Service \(type) is not registered in DIContainer")
    }
}
