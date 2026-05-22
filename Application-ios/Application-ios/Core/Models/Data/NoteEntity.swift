//
//  NoteEntity.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation
import SwiftData

@Model
final class NoteEntity: Identifiable, Hashable {
    
    @Attribute(.unique) var id: UUID
    var title: String
    var text: String
    var createdAt: Date
    
    // Relationship
    var book: BookEntity?
    
    init(title: String, text: String, createdAt: Date, book: BookEntity? = nil) {
        self.id = UUID()
        self.title = title
        self.text = text
        self.createdAt = createdAt
        self.book = book
    }
}
