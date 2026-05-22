//
//  HomeView.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    
    @StateObject private var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content()
    }
}

private extension HomeView {
    
    // MARK: - Content
    
    @ViewBuilder
    private func content() -> some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .tint(.orange)
            } else {
                List {
                    ForEach(viewModel.books) { book in
                        NavigationLink(value: HomeRoute.details(book: book)) {
                            row(with: book)
                        }
                    }
                }
                .refreshable {
                    await viewModel.performRefresh()
                }
            }
        }
        .navigationTitle("Home")
        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("Ok") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
        .navigationDestination(for: HomeRoute.self) { route in
            switch route {
            case .details(let book):
                DetailsView(viewModel: DIContainer.shared.resolve(DetailsViewModel.self, argument: book))
            }
        }
        .task {
            await viewModel.fetchBooks()
            if viewModel.books.isEmpty {
                await viewModel.performSearch()
            }
            
        }
    }
    
    @ViewBuilder
    private func row(with book: BookEntity) -> some View {
        HStack(spacing: 12) {
            KFImage(URL(string: book.imageLink ?? ""))
                .loadDiskFileSynchronously()
                .placeholder {
                    Rectangle().fill(.gray.tertiary)
                }
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(book.title)
                    .font(.headline)
                    .lineLimit(2)
                    .foregroundStyle(.primary)
                if let authors = book.authors {
                    Text(authors.joined(separator: ", "))
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                if let pages = book.pageCount {
                    Text("\(pages) pages")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.vertical, 4)
    }
}
