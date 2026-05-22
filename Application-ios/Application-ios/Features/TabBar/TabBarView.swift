//
//  TabBarView.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import SwiftUI

struct TabBarView: View {
    
    @StateObject private var viewModel: TabBarViewModel
    
    init(viewModel: TabBarViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content()
    }
}

private extension TabBarView {
    
    // MARK: - Content
    
    @ViewBuilder
    private func content() -> some View {
        TabView(selection: $viewModel.selectedTab) {
            ForEach(TabType.allCases, id: \.self) { tab in
                Tab(tab.title, systemImage: tab.systemImage, value: tab) {
                    NavigationStack {
                        ZStack {
                        }
                    }
                }
            }
        }
    }
}
