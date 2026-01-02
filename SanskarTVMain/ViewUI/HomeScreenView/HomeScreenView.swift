//
//  HomeScreenView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/12/25.
//

import SwiftUI

struct HomeScreenView: View {

    @StateObject private var viewModel = HomeViewModel()
    @EnvironmentObject var uiState: AppUIState
    @State private var selectedVideoURL: URL?
    @State private var selectedChannelId: String?
    
    private var screenSize: CGRect {
        UIScreen.main.bounds
    }
    
    private var videoHeight: CGFloat {
        screenSize.width * 9 / 16
    }
    var body: some View {
        VStack(spacing: 0) {
            
            if let url = selectedVideoURL {
                VideoPlayerManager(
                    url: url,  
                    size: UIScreen.main.bounds.size,
                    safeArea: EdgeInsets(),
                    resumeTime: viewModel.resumeTime,
                    isRotated: $viewModel.isRotated
                )
                .id(url)
                .frame(
                    width: screenSize.width,
                    height: viewModel.isRotated
                        ? screenSize.height
                        : videoHeight
                )
                .onChange(of: viewModel.isRotated) { isFull in
                    uiState.isVideoFullscreen = isFull
                }
            }

            if !viewModel.isRotated {
                ScrollView {
                    LazyVStack(spacing: 24) {
                        if let menus = viewModel.menuResponse?.data {
                            ForEach(menus, id: \.id) { menu in
                                HomeSectionView(
                                    onItemTap: playVideo, menu: menu,selectedChannelId: selectedChannelId   
                                ).environmentObject(viewModel)
                            }
                        } else if viewModel.isLoading {
                            ProgressView()
                                .padding(.top, 40)
                        }
                    }
                    .padding(.vertical)
                }
            }
        }
        .ignoresSafeArea(.all, edges: viewModel.isRotated ? .all : [])
        .task {
            await viewModel.getMenuMaster()
        }
    }
    func playVideo(_ item: List) {

        let urlString =
            item.channel_url ??
            item.custom_episode_url

        guard let finalURL = urlString,
              let url = URL(string: finalURL) else {
            return
        }
        viewModel.isVideoPlaying = false
        viewModel.currentlyPlayingEpisodeId = nil
        viewModel.currentlyPlayingId = nil

        // 🔥 SET NEW
        selectedVideoURL = url
        selectedChannelId = item.id
        viewModel.resumeTime = Double(item.pause_at ?? "0") ?? 0
        viewModel.currentlyPlayingId = item.id
        viewModel.currentlyPlayingEpisodeId = item.episode_id
        viewModel.isVideoPlaying = true
    }

}
