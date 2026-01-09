//
//  SplashView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/12/25.
//
import SwiftUI
import AVFoundation

enum SplashRoute: Hashable {
    case home
}


struct SplashView: View {

    @State private var player: AVPlayer? = nil
    @State private var path = NavigationPath()

    let isLoggedIn = false
    @StateObject private var uiState = AppUIState()

    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                if let player {
                    CustomVideoPlayer(player: player)
                        .ignoresSafeArea()
                }
            }
            .navigationDestination(for: SplashRoute.self) { route in
                switch route {
                case .home:
                    MAinTabbarVC()
                        .environmentObject(uiState)
                }
            }
            .onAppear {
                playVideo()
            }
            .onDisappear {
                player?.pause()
                removeObserver()
            }
        }
    }

    // ▶️ Play splash video
    private func playVideo() {
        guard let url = Bundle.main.url(
            forResource: "sanskarlogo",
            withExtension: "mp4"
        ) else {
            print("❌ Video not found")
            return
        }

        let avPlayer = AVPlayer(url: url)
        avPlayer.volume = 0
        self.player = avPlayer

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: avPlayer.currentItem,
            queue: .main
        ) { _ in
            path.append(SplashRoute.home)   // ✅ PUSH
        }

        avPlayer.play()
    }

    private func removeObserver() {
        NotificationCenter.default.removeObserver(
            self,
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }
}
