//
//  YouTubePlayerScreen.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 28/01/26.
//
import SwiftUI

struct VideoPlayerScreen: View {
    let title: String
    let videoID: String

    var body: some View {
        VStack(spacing: 16) {

            Text(title)
                .font(.title2)
                .bold()
                .padding(.horizontal)

            YouTubePlayerView(videoID: videoID, playlistID: nil)
                .frame(height: 240)
                .cornerRadius(12)
                .padding(.horizontal)

            Button {
                openInYouTube()
            } label: {
                Label("Watch on YouTube", systemImage: "play.circle.fill")
                    .font(.headline)
            }

            Spacer()
        }
        .navigationTitle("Now Playing")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func openInYouTube() {
        let appURL = URL(string: "youtube://\(videoID)")!
        let webURL = URL(string: "https://www.youtube.com/watch?v=\(videoID)")!

        if UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else {
            UIApplication.shared.open(webURL)
        }
    }
}
