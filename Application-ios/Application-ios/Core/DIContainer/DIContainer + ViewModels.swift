//
//  DIContainer + ViewModels.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation

extension DIContainer {
    
    func setupViewModels() {
        register(TabBarViewModel.self) {
            TabBarViewModel()
        }
    }
}
