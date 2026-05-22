//
//  BookDTO.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation

struct BookDTO: Identifiable, Codable, Sendable {
    
    let id: String
    let volumeInfo: VolumeInfo
    
    struct VolumeInfo: Codable, Sendable {
        
        let title: String?
        let subtitle: String?
        let authors: [String]?
        let publisher: String?
        let publishedDate: String?
        let description: String?
        let pageCount: Int?
        let categories: [String]?
        let imageLinks: ImageLinks?
    }
    
    struct ImageLinks: Codable, Sendable {
        let thumbnail: String?
    }
}
