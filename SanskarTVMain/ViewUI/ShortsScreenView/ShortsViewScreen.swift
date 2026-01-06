//
//  ShortsViewScreen.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 06/01/26.
//

import SwiftUI

struct ShortsViewScreen: View {
    @StateObject private var viewModel = ShortsViewModel()
    @StateObject private var playback = ReelsPlaybackManager.shared
    @EnvironmentObject var uiState: AppUIState

    @State private var visibleID: String?

    var body: some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.reels) { reel in
                        ReelPlayerView(
                            reel: reel,
                            isActive: visibleID == reel.id
                        )
                        .frame(width: geo.size.width,
                               height: geo.size.height)
                        .id(reel.id)
                    }
                }
            }
            .scrollIndicators(.hidden)
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $visibleID)
        }
        .ignoresSafeArea()
        .onAppear {
            uiState.isHideNavbar = true
        }
        .onDisappear {
            uiState.isHideNavbar = false
            playback.pause()
        }
        .onChange(of: visibleID) { id in
            guard
                let id,
                let index = viewModel.reels.firstIndex(where: { $0.id == id })
            else { return }

            let current = viewModel.reels[index]
            let next = index + 1 < viewModel.reels.count
                ? viewModel.reels[index + 1]
                : nil

            playback.play(reel: current, nextReel: next)
        }
        .task {
            await viewModel.fetchShorts()
            visibleID = viewModel.reels.first?.id
        }
    }
}










import SwiftUI
import AVKit

struct ReelPlayerView: View {
    let reel: Reel
    let isActive: Bool

    @State private var isMuted = false
    @State private var showVolumeIcon = false

    var body: some View {
        ZStack {
            if isActive {
                CustomVideoPlayer(player: ReelsPlaybackManager.shared.player)
                    .ignoresSafeArea()
            } else {
                Color.black
            }

            // Overlay
            VStack {
                Spacer()

                HStack {
                    VStack(alignment: .leading, spacing: 6) {
                        Text(reel.title ?? "")
                            .bold()
                        Text(reel.description ?? "")
                            .font(.caption)
                            .lineLimit(3)
                    }
                    .foregroundColor(.white)

                    Spacer()

                    VStack(spacing: 22) {
                        icon("heart.fill")
                        icon("message.fill")
                        icon("arrowshape.turn.up.right.fill")
                    }
                }
                .padding()
                .padding(.bottom, 90)
            }

            if showVolumeIcon {
                Image(systemName: isMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    .padding()
                    .background(.black.opacity(0.6))
                    .clipShape(Circle())
                    .foregroundColor(.white)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isMuted.toggle()
            ReelsPlaybackManager.shared.player.isMuted = isMuted

            withAnimation { showVolumeIcon = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                withAnimation { showVolumeIcon = false }
            }
        }
    }

    private func icon(_ name: String) -> some View {
        Image(systemName: name)
            .font(.title2)
            .foregroundColor(.white)
    }
}



import AVKit
import Combine

final class ReelsPlaybackManager: ObservableObject {
    static let shared = ReelsPlaybackManager()

    let player = AVPlayer()
    @Published var currentReelID: String?
    private var preloadedItem: AVPlayerItem?

    private init() {
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loopVideo),
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }

    func play(reel: Reel, nextReel: Reel?) {
        guard currentReelID != reel.id else { return }
        currentReelID = reel.id

        player.pause()   // 👈 safety

        let item = preloadedItem ?? makeItem(url: reel.videoURL)
        preloadedItem = nil

        player.replaceCurrentItem(with: item)
        player.play()

        if let next = nextReel {
            preloadedItem = makeItem(url: next.videoURL)
        }
    }


    private func makeItem(url: String) -> AVPlayerItem {
        let item = AVPlayerItem(url: URL(string: url)!)
        item.preferredForwardBufferDuration = 5
        return item
    }

    @objc private func loopVideo() {
        player.seek(to: .zero)
        player.play()
    }

    func pause() {
        player.pause()
    }
}

struct Reel: Identifiable {
    let id: String
    let title: String?
    let description: String?
    let thumbnail: String?
    let videoURL: String

    init(short: Shorts) {
        self.id = short.id ?? UUID().uuidString
        self.title = short.title
        self.description = short.description
        self.thumbnail = short.thumbnail
        self.videoURL = short.video_url ?? ""
    }
}
