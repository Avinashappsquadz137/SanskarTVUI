//
//  MasterSearchView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 13/01/26.
//
import SwiftUI

struct MasterSearchView: View {

    @StateObject private var viewModel = MasterSearchViewModel()
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(spacing: 12) {

            searchBar

            ScrollView {
                if viewModel.searchText.isEmpty {
                    Text("Start typing to search")
                        .foregroundColor(.gray)
                        .padding(.top, 40)
                }
                else if viewModel.isLoading {
                    ProgressView()
                        .padding(.top, 40)
                }
                else if viewModel.result == nil {
                    Text("No results found")
                        .foregroundColor(.gray)
                        .padding(.top, 40)
                }
                else {
                    resultsView
                }
            }


        }
        .padding(.top)
        .background(Color.white.ignoresSafeArea())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isFocused = true
            }
        }
    }
}


private extension MasterSearchView {
    var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search anything...", text: $viewModel.searchText)
                .focused($isFocused)

            if !viewModel.searchText.isEmpty {
                Button {
                    viewModel.searchText = ""
                } label: {
                    Image(systemName: "xmark")
                }
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

private extension MasterSearchView {
    var resultsView: some View {
        VStack(spacing: 24) {

            if let premium = viewModel.result?.premium, !premium.isEmpty {
                SearchSection(
                    title: "Top Premium Search",
                    hasData: !(viewModel.result?.premium?.isEmpty ?? true)
                ) {
                    ForEach(viewModel.result?.premium ?? [], id: \.id) { item in
                        PremiumCard(item: item)
                    }
                }
                .onAppear {
                    print("✅ Premium Count:", premium.count)
                    print("📦 Premium Data:", premium)
                }
            }

            if let videos = viewModel.result?.videos, !videos.isEmpty {
                SearchSection(
                    title: "Top Videos Search",
                    hasData: !(viewModel.result?.videos?.isEmpty ?? true)
                ) {
                    ForEach(viewModel.result?.videos ?? [], id: \.id) { item in
                        VideoRow(item: item)
                    }
                }
                
            }

            if let musics = viewModel.result?.musics, !musics.isEmpty {
                SearchSection(
                    title: "Top Musics Search",
                    hasData: !(viewModel.result?.musics?.isEmpty ?? true)
                ) {
                    ForEach(viewModel.result?.musics ?? [], id: \.id) { item in
                        MusicRow(item: item)
                    }
                }
              
            }
        }
        
        .padding(.bottom, 20)
    }
}
struct SearchSection<Content: View>: View {
    let title: String
    let hasData: Bool
    let content: Content

    init(
        title: String,
        hasData: Bool,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.hasData = hasData
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text(title)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.orange)

            if hasData {
                content
            } else {
                Text("No items found")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
            }
        }
    }
}

import SwiftUI

struct PremiumCard: View {

    let item: MasterSearchPremium

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            AsyncImage(url: URL(string: item.season_banner ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(height: 160)
            .clipped()
            .cornerRadius(12)

            Text(item.season_title ?? "")
                .font(.headline)
                .lineLimit(2)

            Text(item.location ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding(.horizontal)
    }
}
import SwiftUI

struct VideoRow: View {

    let item: MasterSearchVideo

    var body: some View {
        HStack(spacing: 12) {

            AsyncImage(url: URL(string: item.thumbnail_url ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 120, height: 70)
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.video_title ?? "")
                    .font(.headline)
                    .lineLimit(2)

                Text(item.author_name ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}
import SwiftUI

struct MusicRow: View {

    let item: MasterSearchMusics

    var body: some View {
        HStack(spacing: 12) {

            AsyncImage(url: URL(string: item.thumbnail1 ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Color.gray.opacity(0.3)
            }
            .frame(width: 60, height: 60)
            .cornerRadius(8)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.title ?? "")
                    .font(.headline)
                    .lineLimit(1)

                Text(item.artist_name ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding(.horizontal)
    }
}
