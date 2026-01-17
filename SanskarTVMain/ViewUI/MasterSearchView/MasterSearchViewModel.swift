//
//  MasterSearchViewModel.swift
//  SanskarTVMain
//
//  Created by Sanskar IOS Dev on 14/01/26.
//
import Foundation
import Combine

@MainActor
final class MasterSearchViewModel: ObservableObject {

    // MARK: - Input
    @Published var searchText: String = ""
    @Published var hasSearched: Bool = false

    // MARK: - Output
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var result: MasterSearch?

    // MARK: - Pagination (optional)
    private var canLoadMore = true
    private var cancellables = Set<AnyCancellable>()

    init() {
        observeSearch()
    }
    var isResultEmpty: Bool {
        guard let result else { return true }

        let premiumEmpty = result.premium?.isEmpty ?? true
        let videosEmpty  = result.videos?.isEmpty ?? true
        let musicsEmpty  = result.musics?.isEmpty ?? true

        return premiumEmpty && videosEmpty && musicsEmpty
    }

    // MARK: - Search Observer
    private func observeSearch() {
        $searchText
            .debounce(for: .milliseconds(400), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self else { return }

                if text.trimmingCharacters(in: .whitespaces).isEmpty {
                    self.result = nil
                    self.hasSearched = false
                } else {
                    self.search(reset: true)
                }
            }
            .store(in: &cancellables)
    }


    // MARK: - API Call
    func search(reset: Bool = false) {
        let trimmed = searchText.trimmingCharacters(in: .whitespaces)

        guard !trimmed.isEmpty else {
            result = nil
            hasSearched = false
            return
        }

        if reset {
            hasSearched = true
            result = nil
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let response: MasterSearchModel =
                try await ApiClient.shared.request(
                    endpoint: Constant.masterSearchCentralSearch,
                    method: .post,
                    parameters: [
                        "search": trimmed,
                        "user_id": "645485"
                    ],
                    isMultipart: true
                )

                result = response.data
                isLoading = false
            } catch {
                isLoading = false
                errorMessage = error.localizedDescription
            }
        }
    }


}

