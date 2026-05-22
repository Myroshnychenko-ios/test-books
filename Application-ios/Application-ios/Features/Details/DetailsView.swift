//
//  DetailsView.swift
//  Application-ios
//
//  Created by Myroshnychenko Maxym on 22.05.2026.
//

import SwiftUI
import Kingfisher

enum DetailsRoute: Hashable {
    case notes(book: BookEntity)
}

struct DetailsView: View {
    
    @StateObject private var viewModel: DetailsViewModel
    
    init(viewModel: DetailsViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        content()
    }
}

private extension DetailsView {
    
    // MARK: - Content
    
    @ViewBuilder
    private func content() -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                cover(from: viewModel.book)
                data(from: viewModel.book)
                description(from: viewModel.book)
                notesButton()
            }
            .padding()
        }
        .navigationTitle(viewModel.book.title)
        .task {
            viewModel.fetchNotes()
        }
    }
    
    @ViewBuilder
    private func cover(from book: BookEntity) -> some View {
        KFImage(URL(string: book.imageLink ?? ""))
            .loadDiskFileSynchronously()
            .placeholder {
                Rectangle().fill(.gray.tertiary)
            }
            .resizable()
            .aspectRatio(contentMode: .fit)
            .scaledToFit()
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    @ViewBuilder
    private func data(from book: BookEntity) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if let authors = book.authors {
                Text(authors.joined(separator: ", "))
                    .font(.title3)
                    .foregroundStyle(.primary)
            }
            if let publisher = book.publisher {
                Text("Publisher: \(publisher)")
                    .foregroundStyle(.secondary)
            }
            if let date = book.publishedDate {
                Text("Published: \(date)")
                    .foregroundStyle(.secondary)
            }
            if let pages = book.pageCount {
                Text("\(pages) pages")
                    .foregroundStyle(.secondary)
            }
        }
    }
    
    @ViewBuilder
    private func description(from book: BookEntity) -> some View {
        if let description = book.bookDescription {
            Text(description)
                .padding(.top)
        }
    }
    
    @ViewBuilder
    private func notesButton() -> some View {
        NavigationLink("Notes (\(viewModel.notes.count))") {
            ZStack {
                // TODO
            }
        }
        .buttonStyle(.borderedProminent)
    }
}
