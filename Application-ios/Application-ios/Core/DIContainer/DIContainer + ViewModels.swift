//
//  DIContainer + ViewModels.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation
import SwiftData

extension DIContainer {
    
    func setupViewModels() {
        register(TabBarViewModel.self) {
            TabBarViewModel()
        }
        
        register(HomeViewModel.self) { [weak self] in
            guard let self else {
                fatalError("DIContainer deallocated")
            }
            
            let network = self.resolve(NetworkAPIProtocol.self)
            let container = self.resolve(ModelContainer.self)
            
            return HomeViewModel(network: network, modelContext: ModelContext(container))
        }
    }
}
