//
//  YouTubeViewModels.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/01/26.
//
import SwiftUI
import Combine

@MainActor
final class VideoDetailViewModel: ObservableObject {

    @Published var suggestions: [YouTubeVideo] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let videoID: String
    private let menuMasterID: String
    private var page = 1

    init(videoID: String, menuMasterID: String) {
        self.videoID = videoID
        self.menuMasterID = menuMasterID
    }

    func fetchSuggestions(reset: Bool = false) async {

        if reset {
            page = 1
            suggestions.removeAll()
        }

        isLoading = true

        do {
            let response: YouTubeVideoModels =
            try await ApiClient.shared.request(
                endpoint: Constant.getSuggestionByVideoMaster,
                method: .post,
                parameters: [
                    "user_id": "645485",
                   // "menu_master_id": menuMasterID,   // ✅ FIXED
                    "page_no": "\(page)",
                    "video_id": videoID,
                    "limit": "100"
                ],
                isMultipart: true
            )

            suggestions.append(contentsOf: response.data ?? [])
            page += 1

        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
}
