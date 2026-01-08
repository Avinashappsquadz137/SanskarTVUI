//
//  ShortsViewModel.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 02/01/26.
//
import Combine
import SwiftUI

@MainActor
final class ShortsViewModel: ObservableObject {

    @Published var reels: [Reel] = []

    func fetchShorts() async {
        do {
            let response: ShortsModels = try await ApiClient.shared.request(
                endpoint: Constant.getShortsVideo,
                method: .post,
                parameters: ["user_id": "684495"],
                isMultipart: false
            )

            self.reels = (response.data ?? []).compactMap { Reel(short: $0) }


        } catch {
            print("❌ Shorts Error:", error.localizedDescription)
        }
    }
}
