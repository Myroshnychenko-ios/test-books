//
//  DetailsViewModel.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation
import Combine
import SwiftData

@MainActor
final class DetailsViewModel: ObservableObject {
    
    // MARK: - Injected Dependencies
    
    private let modelContext: ModelContext
    
    let book: BookEntity
    
    // MARK: - Published properties
    
    @Published var notes: [NoteEntity] = []
    
    init(modelContext: ModelContext, book: BookEntity) {
        self.modelContext = modelContext
        self.book = book
    }
    
    func fetchNotes() {
        notes = book.notes.sorted { $0.createdAt > $1.createdAt }
    }
}
