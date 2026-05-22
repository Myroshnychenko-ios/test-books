//
//  HomeViewModel.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation
import Combine
import SwiftData

enum HomeRoute: Hashable {
    case details(book: BookEntity)
}

@MainActor
final class HomeViewModel: ObservableObject {
    
    // MARK: - Injected Dependencies
    
    private let network: NetworkAPIProtocol
    private let modelContext: ModelContext
    
    // MARK: - Published properties
    
    @Published var query: String = "swift"
    @Published var books: [BookEntity] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let maxResults: Int = 40
    
    init(network: NetworkAPIProtocol, modelContext: ModelContext) {
        self.network = network
        self.modelContext = modelContext
    }
    
    func fetchBooks() async {
        let descriptor = FetchDescriptor<BookEntity>(sortBy: [SortDescriptor(\.title)])
        do {
            books = try modelContext.fetch(descriptor)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func performRefresh() async {
        do {
            let dtos = try await network.searchBooks(query: query, maxResults: maxResults)
            saveBooks(dtos)
            await fetchBooks()
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    func performSearch() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let dtos = try await network.searchBooks(query: query, maxResults: maxResults)
            saveBooks(dtos)
            await fetchBooks()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    private func saveBooks(_ dtos: [BookDTO]) {
        for dto in dtos {
            let dtoID = dto.id
            let descriptor = FetchDescriptor<BookEntity>(predicate: #Predicate { $0.id == dtoID })
            let existing = try? modelContext.fetch(descriptor).first
            if existing == nil {
                let entity = BookEntity(from: dto)
                modelContext.insert(entity)
            }
        }
        try? modelContext.save()
    }
}
