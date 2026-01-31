//
//  YouTubePlayerView.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 28/01/26.
//

import SwiftUI
import WebKit

struct YouTubePlayerView: UIViewRepresentable {

    let videoID: String?
    let playlistID: String?

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []

        let webView = WKWebView(frame: .zero, configuration: config)
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.backgroundColor = .black
        webView.isOpaque = false

        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let html = buildHTML()
        webView.loadHTMLString(html, baseURL: URL(string: "https://www.youtube-nocookie.com"))
    }

    // MARK: - HTML Builder
    private func buildHTML() -> String {

        let src: String

        if let playlistID {
            let cleanID = sanitize(playlistID)
            src = "https://www.youtube-nocookie.com/embed/videoseries?list=\(cleanID)&playsinline=1&modestbranding=1&rel=0"
        } else if let videoID {
            let cleanID = sanitize(videoID)
            src = "https://www.youtube-nocookie.com/embed/\(cleanID)?playsinline=1&modestbranding=1&rel=0"
        } else {
            return "<html><body>No video</body></html>"
        }

        return """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body {
                    margin: 0;
                    background-color: black;
                }
                iframe {
                    position: absolute;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                }
            </style>
        </head>
        <body>
            <iframe
                src="\(src)"
                frameborder="0"
                allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
                allowfullscreen>
            </iframe>
        </body>
        </html>
        """
    }

    // MARK: - Helpers
    private func sanitize(_ id: String) -> String {
        id.components(separatedBy: ["?", "&"]).first ?? id
    }
}
