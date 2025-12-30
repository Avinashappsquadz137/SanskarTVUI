//
//  HomeScreenView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/12/25.
//

import SwiftUI

struct HomeScreenView: View {

    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        VStack(spacing: 0) {

            // ✅ VIDEO (fixed height)
            VideoPlayerManager(
                url: URL(string: "https://d26idhjf0y1p2g.cloudfront.net/out/v1/cd66dd25b9774cb29943bab54bbf3e2f/index.m3u8")!,
                size: UIScreen.main.bounds.size,
                safeArea: EdgeInsets(),
                isRotated: $viewModel.isRotated
            )
            .frame(height: viewModel.isRotated ? UIScreen.main.bounds.height : 250)
          

            // ✅ CONTENT (scrollable)
            if !viewModel.isRotated {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        if let menus = viewModel.menuResponse?.data {
                            ForEach(menus, id: \.id) { menu in
                                Text(menu.menu_title ?? "")
                                    .font(.headline)
                            }
                        } else if viewModel.isLoading {
                            ProgressView()
                        }
                    }
                    .padding()
                }
                .zIndex(0)
            }
        }
        .ignoresSafeArea(.all, edges: viewModel.isRotated ? .all : [])
        .task {
            await viewModel.getMenuMaster()
        }
    }
}
