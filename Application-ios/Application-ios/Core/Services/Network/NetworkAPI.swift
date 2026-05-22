//
//  Network.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation

protocol NetworkAPIProtocol: Actor {
    
    func searchBook(query: String, maxResult: Int) async throws -> [BookDTO]
}
