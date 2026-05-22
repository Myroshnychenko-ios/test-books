//
//  DIContainer + ModelContainer.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation
import SwiftData

extension DIContainer {
    
    func setupPersistence(container: ModelContainer) {
        register(ModelContainer.self, instance: container)
    }
}
