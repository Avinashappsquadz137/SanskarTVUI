//
//  VideoScreen.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/12/25.
//

import SwiftUI

struct VideoScreen: View {

    @StateObject private var viewModel = VideoViewModel()
    @State private var didLoad = false

    var body: some View {
        VStack(spacing: 0) {

            // 🔹 Category Tabs
            CategoryTabsView(
                categories: viewModel.categories,
                selected: $viewModel.selectedCategory
            )
            .padding(.vertical, 8)

            // 🔹 Video List
            ScrollView {
                LazyVStack(spacing: 16) {

                    ForEach(viewModel.videos, id: \.id) { video in
                        NavigationLink {
                            VideoDetailView(
                                video: video,
                                menuMasterID: viewModel.selectedCategory
                            )
                        } label: {
                            VideoCardView(video: video)
                                .onAppear {
                                    if video.id == viewModel.videos.last?.id {
                                        Task {
                                            await viewModel.loadMoreVideos()
                                        }
                                    }
                                }
                        }
                        .buttonStyle(.plain)
                    }

                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .padding(.top)
            }
        }
        .onChange(of: viewModel.selectedCategory) { _ in
            Task {
                await viewModel.resetAndFetch()
            }
        }
        .onAppear {
            guard !didLoad else { return }
            didLoad = true

            Task {
                await viewModel.fetchVideos()
            }
        }
    }
}
