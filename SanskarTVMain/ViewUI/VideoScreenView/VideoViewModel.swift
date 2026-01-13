//
//  VideoViewModel.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 10/01/26.
//
import SwiftUI
import Combine

@MainActor
class VideoViewModel: ObservableObject {

    @Published var categories: [Category] = []
    @Published var videos: [Videos] = []
    @Published var selectedCategory: String = ""

    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var hasMore = true

    // MARK: - Reset & Reload
    func resetAndFetch() async {
        currentPage = 1
        hasMore = true
        videos.removeAll()

        await fetchVideos(page: 1)
    }

    // MARK: - Fetch Videos
    func fetchVideos(page: Int = 1) async {
        guard hasMore, !isLoading else { return }
        isLoading = true

        let params: [String: Any] = [
            "user_id": "666221",
            "search_content": "",
            "video_category": selectedCategory,
            "last_video_id": page == 1 ? "" : (videos.last?.id ?? ""),
            "limit": 10,
            "page_no": page,
            "current_version": "74",
            "device_type": "1"
        ]

        do {
            let response: VideoModels = try await ApiClient.shared.request(
                endpoint: Constant.controlSearchVideos,
                method: .post,
                parameters: params,
                isMultipart: true
            )

            guard response.status == true,
                  let data = response.data else {
                hasMore = false
                isLoading = false
                return
            }

            if page == 1 {
                categories = data.category ?? []
                videos = data.videos ?? []
            } else {
                videos.append(contentsOf: data.videos ?? [])
            }

            hasMore = !(data.videos?.isEmpty ?? true)
            currentPage = page

        } catch {
            print("❌ API Error:", error)
            hasMore = false
        }

        isLoading = false
    }

    func loadMoreVideos() async {
        guard !isLoading, hasMore else { return }
        await fetchVideos(page: currentPage + 1)
    }
}
