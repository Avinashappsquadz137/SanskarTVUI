//
//  SplashView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/12/25.
//
import SwiftUI
import AVFoundation

struct SplashView: View {

    @State private var player: AVPlayer?
    @State private var navigate = false

    let isLoggedIn = false // UserDefaultsManager.isLoggedIn()
    @StateObject private var uiState = AppUIState()
    var body: some View {
        NavigationStack {
            ZStack {
                VideoPlayerContainer(player: $player)
                    .ignoresSafeArea()
                NavigationLink(
                    destination: destinationView,
                    isActive: $navigate
                ) {
                    EmptyView()
                }
            }
            .onAppear {
                playVideo()
            }
            .onDisappear {
                player?.pause()
            }
        }
    }

    @ViewBuilder
    private var destinationView: some View {
        if isLoggedIn {
            MAinTabbarVC()
                .environmentObject(uiState)
        } else {
            MAinTabbarVC()
                .environmentObject(uiState)
        }
    }

    // ▶️ Play splash video
    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "sanskarlogo", ofType: "mp4") else {
            print("Video not found")
            return
        }

        let url = URL(fileURLWithPath: path)
        let player = AVPlayer(url: url)
        player.volume = 0
        self.player = player

        NotificationCenter.default.addObserver(
            forName: .AVPlayerItemDidPlayToEndTime,
            object: player.currentItem,
            queue: .main
        ) { _ in
            navigate = true
        }

        player.play()
    }
}

struct VideoPlayerContainer: UIViewRepresentable {

    @Binding var player: AVPlayer?

    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        guard let player else { return }

        let layer = AVPlayerLayer(player: player)
        layer.frame = uiView.bounds
        layer.videoGravity = .resizeAspectFill

        uiView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        uiView.layer.addSublayer(layer)
    }
}
