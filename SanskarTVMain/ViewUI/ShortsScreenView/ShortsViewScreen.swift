//
//  ShortsViewScreen.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 06/01/26.
//

import SwiftUI
import AVKit
import Combine
import UIKit
import AVFoundation

struct ShortsViewScreen: View {
    @StateObject private var viewModel = ShortsViewModel()
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
            .scrollTargetLayout()
            .scrollTargetBehavior(.paging)
            .scrollPosition(id: $visibleID)
        }
        .ignoresSafeArea()
        .task {
            await viewModel.fetchShorts()
            visibleID = viewModel.reels.first?.id
        }
        .onDisappear {
            ShortsVideoUIView.stopAllPlayers()
        }

    }
}

struct ReelPlayerView: View {

    let reel: Reel
    let isActive: Bool

    @State private var hideThumbnail = false
    @State private var showPlayPauseIcon = false
    @State private var isPaused = false
    @State private var isLiked = false
    @State private var likeCount = 0
    init(reel: Reel, isActive: Bool) {
           self.reel = reel
           self.isActive = isActive
           _likeCount = State(initialValue: Int(reel.totalLike) ?? 0)
       }
    var body: some View {
        ZStack {
            VStack{
   
                ShortsVideoView(
                    videoURL: reel.videoURL,
                    isActive: isActive, isPaused: isPaused,
                    isReadyToPlay: $hideThumbnail
                )
                .offset(y: -30)
                .background(
                    AsyncImage(url: URL(string: reel.thumbnail ?? "")) { img in
                        img
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        Color.black
                    }
                        .opacity(hideThumbnail ? 0 : 1)
                )
                .clipped()
                
            }
            overlayUI

        }
        .onTapGesture {
            isPaused.toggle()
            showPlayPauseIcon = true

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                showPlayPauseIcon = false
            }
        }
        .overlay {
            if showPlayPauseIcon {
                Image(systemName: isPaused ? "play.fill" : "pause.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.white)
                    .scaleEffect(1.1)
                    .transition(.scale)
            }
        }
        .clipped()
        .contentShape(Rectangle())
    }

    private var overlayUI: some View {
        VStack {
            Spacer()
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 6) {
                    Text(reel.title ?? "")
                        .font(.headline)
                        .bold()
                        .foregroundColor(.white)
                        .lineLimit(2)

                    Text(reel.description ?? "")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.85))
                        .lineLimit(2)
                }

                Spacer()
                VStack(spacing: 22) {
                    actionItem(
                        icon: "heart.fill",
                        count: likeCount,
                        isLike: true
                    )
                    actionItem(icon: "message.fill", count: reel.totalComment)
                    actionItem(icon: "arrowshape.turn.up.right.fill", count: reel.totalShare)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 80)
        }
    }

    private func actionItem(
        icon: String,
        count: Int,
        isLike: Bool = false
    ) -> some View {

        Button {
            if isLike {
                toggleLike()
            }
        } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(
                        isLike && isLiked ? .pink : .white
                    )
                    .scaleEffect(
                        isLike && isLiked ? 1.25 : 1.0
                    )
                    .animation(
                        .spring(response: 0.3, dampingFraction: 0.6),
                        value: isLiked
                    )

                Text("\(count)")
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
    }
    private func toggleLike() {
        isLiked.toggle()
        if isLiked {
            likeCount += 1
            HapticManager.shared.impact(style: .medium)
        } else {
            likeCount -= 1
            HapticManager.shared.impact(style: .light)
        }
    }

    private func actionItem(icon: String, count: String) -> some View
    {
        VStack
        {
            
            Image(systemName: icon)
            Text(count).font(.caption)
        } .foregroundColor(.white)
    }
}

struct ShortsVideoView: UIViewRepresentable {

    let videoURL: String
    let isActive: Bool
    let isPaused: Bool
    @Binding var isReadyToPlay: Bool

    func makeUIView(context: Context) -> ShortsVideoUIView {
        let view = ShortsVideoUIView()
        view.onReadyToPlay = {
            DispatchQueue.main.async {
                isReadyToPlay = true
            }
        }
        return view
    }

    func updateUIView(_ uiView: ShortsVideoUIView, context: Context) {

        if isActive {
            uiView.playIfNeeded(url: videoURL)
        } else {
            uiView.stopAndReset()
        }

        if isPaused {
            uiView.pause()
        } else {
            uiView.play()
        }
    }
}


final class ShortsVideoUIView: UIView {

    private let player = AVPlayer()
    private let playerLayer = AVPlayerLayer()
    private var currentURL: String?
    private static var activePlayers: [AVPlayer] = []
    var onReadyToPlay: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    static func stopAllPlayers() {
           activePlayers.forEach {
               $0.pause()
               $0.replaceCurrentItem(with: nil)
           }
           activePlayers.removeAll()
       }
    private func setup() {
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspect
        layer.backgroundColor = UIColor.black.cgColor
        layer.addSublayer(playerLayer)
        ShortsVideoUIView.activePlayers.append(player)
        player.addObserver(self, forKeyPath: "timeControlStatus", options: [.new], context: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(loop),
            name: .AVPlayerItemDidPlayToEndTime,
            object: nil
        )
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        CATransaction.begin()
        CATransaction.setDisableActions(true)
        playerLayer.frame = bounds
        CATransaction.commit()
    }


    func playIfNeeded(url: String) {
        if currentURL == url {
            player.play()
            return
        }

        currentURL = url
        guard let videoURL = URL(string: url) else { return }

        let item = AVPlayerItem(url: videoURL)
        item.preferredForwardBufferDuration = 8
        player.replaceCurrentItem(with: item)
        player.play()
    }

    func pause() {
        player.pause()
      
    }

    func play() {
        player.play()
    }

    @objc private func loop() {
        player.seek(to: .zero)
        player.play()
    }
    func stopAndReset() {
        player.pause()
        player.seek(to: .zero)
        player.replaceCurrentItem(with: nil)
        currentURL = nil
    }

    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {
        if keyPath == "timeControlStatus",
           player.timeControlStatus == .playing {
            onReadyToPlay?()
        }
    }
    deinit {
            player.pause()
            player.replaceCurrentItem(with: nil)
            ShortsVideoUIView.activePlayers.removeAll { $0 === player }
            player.removeObserver(self, forKeyPath: "timeControlStatus")
            NotificationCenter.default.removeObserver(self)
        }
}

