//
//  BookEntity.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation
import SwiftData

@Model
final class BookEntity: Identifiable, Hashable {
    
    @Attribute(.unique) var id: String
    var title: String
    var subtitle: String?
    var authors: [String]?
    var publisher: String?
    var publishedDate: String?
    var bookDescription: String?
    var pageCount: Int?
    var categories: [String]?
    var imageLink: String?
    
    // One-to-Many relationship
    @Relationship(deleteRule: .cascade, inverse: \NoteEntity.book)
    var notes: [NoteEntity] = []
    
    init(from dto: BookDTO) {
        id = dto.id
        title = dto.volumeInfo.title ?? "Unknown Title"
        subtitle = dto.volumeInfo.subtitle
        authors = dto.volumeInfo.authors
        publisher = dto.volumeInfo.publisher
        publishedDate = dto.volumeInfo.publishedDate
        bookDescription = dto.volumeInfo.description
        pageCount = dto.volumeInfo.pageCount
        categories = dto.volumeInfo.categories
        imageLink = dto.volumeInfo.imageLinks?.thumbnail
    }
}
