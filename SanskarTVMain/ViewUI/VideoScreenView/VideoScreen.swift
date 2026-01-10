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
        VStack{
            SwiftUI.List {
                ForEach(viewModel.videos, id: \.id) { video in
                    Text(video.video_title ?? "No Title")
                        .onAppear {
                            if video.id == viewModel.videos.last?.id {
                                Task {
                                    await viewModel.loadMoreVideos()
                                }
                            }
                        }
                }
                
                if viewModel.isLoading {
                    HStack {
                        Spacer()
                        ProgressView()
                        Spacer()
                    }
                }
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
