//
//  NetworkAPI.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import Foundation

protocol NetworkAPIProtocol {
    
    func searchBooks(query: String, maxResults: Int) async throws -> [BookDTO]
}

final class NetworkAPI: NetworkAPIProtocol {
    
    private let baseURL: String
    private let key: String
    
    init() {
        baseURL = "https://www.googleapis.com/books/v1/volumes"
        key = Bundle.main.object(forInfoDictionaryKey: "GOOGLE_BOOKS_API_KEY") as? String ?? ""
    }
    
    func searchBooks(query: String, maxResults: Int = 20) async throws -> [BookDTO] {
        guard !query.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return []
        }
        
        var components = URLComponents(string: baseURL)
        
        components?.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "maxResults", value: "\(maxResults)"),
            URLQueryItem(name: "key", value: key)
        ]
        
        guard let url = components?.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        let result = try decoder.decode(BooksResponse.self, from: data)
        
        return result.items ?? []
    }
}
