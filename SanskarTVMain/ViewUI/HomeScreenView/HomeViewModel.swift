//
//  HomeViewModel.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 29/12/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class HomeViewModel: ObservableObject {

    // MARK: - UI State
    @Published var isRotated: Bool = false
    @Published var menuResponse: GetMenuMasterModels?
    @Published var isLoading: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var errorMessage: String?
    @Published var resumeTime: Double = 0
    @Published var isVideoPlaying: Bool = false
    //@Published var currentlyPlayingId: String? = nil
    @Published var currentlyPlayingEpisodeId: String? = nil
    
    // MARK: - Pagination
    private var currentPage: Int = 1
    private var canLoadMore: Bool = true
    
    // MARK: - API Call
    func getMenuMaster(loadMore: Bool = false) async {

        if loadMore {
            guard canLoadMore, !isLoadingMore else { return }
            isLoadingMore = true
            currentPage += 1
        } else {
            isLoading = true
            currentPage = 1
            canLoadMore = true
        }

        do {
            let response: GetMenuMasterModels =
            try await ApiClient.shared.request(
                endpoint: Constant.getlogin,
                method: .post,
                parameters: [
                    "user_id": "645485",
                    "device_type": "1",
                    "current_version": "44",
                    "page": "\(currentPage)"
                ],
                isMultipart: true
            )
            if loadMore {
                if let newMenus = response.data,
                   let existing = menuResponse?.data {
                    menuResponse?.data = existing + newMenus
                } else {
                    menuResponse = response
                }
            } else {
                menuResponse = response
            }
            if response.data?.isEmpty == true {
                canLoadMore = false
            }
        } catch {
            errorMessage = error.localizedDescription
            print("Pagination Error:", error.localizedDescription)
        }
        isLoading = false
        isLoadingMore = false
    }
}
