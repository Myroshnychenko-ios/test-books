//
//  Application_iosApp.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import SwiftUI
import SwiftData

@main
struct Application_iosApp: App {
    
    // MARK: - SwiftData Model Container
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            BookEntity.self,
            NoteEntity.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    init() {
        DIContainer.shared.setupPersistence(container: sharedModelContainer)
        DIContainer.shared.setupServices()
        DIContainer.shared.setupViewModels()
    }

    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: DIContainer.shared.resolve(TabBarViewModel.self))
        }
        .modelContainer(sharedModelContainer)
    }
}
