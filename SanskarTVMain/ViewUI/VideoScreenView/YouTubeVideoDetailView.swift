//
//  VideoDetailView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 30/01/26.
//
import SwiftUI

struct VideoDetailView: View {
    
    let video: Videos
    let menuMasterID: String
    @State private var selectedVideoID: String
    @StateObject private var viewModel: VideoDetailViewModel
    
    init(video: Videos, menuMasterID: String) {
        self.video = video
        self.menuMasterID = menuMasterID
        _selectedVideoID = State(initialValue: video.youtube_url ?? "")
        _viewModel = StateObject(
            wrappedValue: VideoDetailViewModel(
                videoID: video.id ?? "",
                menuMasterID: menuMasterID
            )
        )
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
            YouTubePlayerView(
                videoID: selectedVideoID,
                playlistID: nil
            )
            .id(selectedVideoID)
            .frame(height: 220)
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.suggestions, id: \.id) { item in
                        VideoCardContent(
                            video: item,
                            isSelected: item.youtube_url == selectedVideoID
                        )
                        .onTapGesture {
                            guard selectedVideoID != item.youtube_url else { return }
                            selectedVideoID = item.youtube_url ?? ""
                        }
                    }
                    if viewModel.isLoading {
                        ProgressView().padding()
                    }
                }
                .padding(5)
            }
        }
        .navigationTitle(video.video_title ?? "")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchSuggestions()
        }
    }
}


struct VideoCardContent: View {
    let video: YouTubeVideo
    let isSelected: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            GeometryReader { geo in
                let width = geo.size.width
                let height = width * 9 / 16
                
                ZStack {
                    AsyncImage(url: URL(string: video.thumbnail_url ?? "")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.gray.opacity(0.3)
                    }
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(12)
                }
            }
            .frame(height: UIScreen.main.bounds.width * 9 / 16)
            Text(video.video_title ?? "")
                .font(.headline)
            
            Text(video.video_desc ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .background(
            isSelected
            ? Color.blue.opacity(0.15)
            : Color(.secondarySystemBackground)
        )
        .cornerRadius(12)
    }
}
