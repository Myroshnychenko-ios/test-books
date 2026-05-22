//
//  TabBarViewModel.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation
import Combine

enum TabType: String, CaseIterable {
    
    case home
    case search
    
    var title: String {
        switch self {
        case .home: return ""
        case .search: return ""
        }
    }
    
    var systemImage: String {
        switch self {
        case .home: return "house"
        case .search: return "magnifyingglass"
        }
    }
}

@MainActor
final class TabBarViewModel: ObservableObject {
    
    // MARK: - Published properties
    
    @Published var selectedTab: TabType = .home
    
    init() {
        // TODO
    }
}
