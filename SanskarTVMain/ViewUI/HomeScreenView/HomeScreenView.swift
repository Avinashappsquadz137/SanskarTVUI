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
                    url: url,   // ✅ direct pass
                    size: UIScreen.main.bounds.size,
                    safeArea: EdgeInsets(),
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
                                )
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

        guard let urlString =
                item.channel_url,
              let url = URL(string: urlString)
        else { return }

        selectedVideoURL = url
        selectedChannelId = item.id      // 🔥 MARK AS LIVE
    }

}
