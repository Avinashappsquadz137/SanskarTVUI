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
    @Published var errorMessage: String?

    // MARK: - API Call
    func getMenuMaster() async {
        isLoading = true
        errorMessage = nil

        do {
            let response: GetMenuMasterModels =
            try await ApiClient.shared.request(
                endpoint: Constant.getlogin,
                method: .post,
                parameters: [
                    "user_id": "645485",
                    "device_type": "1",
                    "current_version": "44"
                ],
                isMultipart: true
            )

            menuResponse = response
            isLoading = false

        } catch {
            isLoading = false
            errorMessage = error.localizedDescription
            print("API Error:", error.localizedDescription)
        }
    }

    // MARK: - Orientation Handling
    func updateOrientation() {
        let orientation = UIDevice.current.orientation
        if orientation.isLandscape {
            isRotated = true
        } else if orientation.isPortrait {
            isRotated = false
        }
    }
}
