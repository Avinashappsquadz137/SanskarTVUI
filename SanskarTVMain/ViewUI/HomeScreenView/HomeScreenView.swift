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
    let defaultURL = URL(string: "https://csm-e-cesharedlsgsin2live-87593235.bln1.yospace.com/csm/extlive/runntvprd01,sanskartv.m3u8?yo.oh=Y3NtLWUtcnVubnR2cHJkbGl2ZS1lYi5ydW5uYWRzLnJ1bm4ubWVkaWE=")!
    private var screenSize: CGRect {
        UIScreen.main.bounds
    }
    
    private var videoHeight: CGFloat {
        screenSize.width * 9 / 16
    }
    var body: some View {
        VStack(spacing: 0) {
            
            VideoPlayerManager(
                url: selectedVideoURL ?? defaultURL,
                size: UIScreen.main.bounds.size,
                safeArea: EdgeInsets(),
                resumeTime: viewModel.resumeTime,
                isRotated: $viewModel.isRotated
            )
            .id(selectedVideoURL)
            .frame(
                width: screenSize.width,
                height: viewModel.isRotated
                ? screenSize.height
                : videoHeight
            )
            .onChange(of: viewModel.isRotated) { isFull in
                uiState.isVideoFullscreen = isFull
            }
            
            
            if !viewModel.isRotated {
                ScrollView {
                    LazyVStack(spacing: 24) {
                        if let menus = viewModel.menuResponse?.data {
                            ForEach(menus.indices, id: \.self) { index in
                                let menu = menus[index]
                                
                                HomeSectionView(
                                    onItemTap: playVideo,
                                    menu: menu,
                                    selectedChannelId: selectedChannelId
                                )
                                .environmentObject(viewModel)
                                .onAppear {
                                    if index == menus.count - 1 {
                                        Task {
                                            await viewModel.getMenuMaster(loadMore: true)
                                        }
                                    }
                                }
                            }
                            
                            if viewModel.isLoadingMore {
                                ProgressView()
                                    .padding(.vertical, 16)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .refreshable {
                    await viewModel.getMenuMaster()
                }
            }
            
        }
        .ignoresSafeArea(.all, edges: viewModel.isRotated ? .all : [])
        .task {
            await viewModel.getMenuMaster()
        }
        
    }
    func playVideo(_ item: List) {
        
        let urlString = item.channel_url ?? item.custom_episode_url
        guard let finalURL = urlString,
              let url = URL(string: finalURL) else { return }
        
        // RESET
        viewModel.isVideoPlaying = false
        viewModel.currentlyPlayingEpisodeId = nil
        //viewModel.currentlyPlayingId = nil
        
        // SET
        selectedVideoURL = url
        selectedChannelId = item.id
        viewModel.resumeTime = Double(item.pause_at ?? "0") ?? 0
        //viewModel.currentlyPlayingId = item.id
        viewModel.currentlyPlayingEpisodeId = item.episode_id
        viewModel.isVideoPlaying = true
    }
    
}
