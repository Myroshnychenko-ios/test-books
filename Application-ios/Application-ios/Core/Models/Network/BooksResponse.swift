//
//  BooksResponse.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation

struct BooksResponse: Codable, Sendable {
    let items: [BookDTO]?
}
