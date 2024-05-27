//
//  FeedViewModel.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Combine
import UIKit

class FeedViewModel: ObservableObject {
    @Published private(set) var images: [ImageModel] = []
    @Published var isRefreshing = false
    @Published var error: Error?

    private let imageService: ImageServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    private var page: UInt = 1

    init(imageService: ImageServiceProtocol) {
        self.imageService = imageService
        fetchImages()
    }

    func fetchImages(isRefresh: Bool = false) {
        page = 1
        isRefreshing = isRefresh
        imageService.fetchImages(page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    guard let `self` = self else { return }

                    self.images = response.results

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { // Change `2.0` to the desired number of seconds.
                        self.isRefreshing = false
                    }

                }
            }
            .store(in: &cancellables)
    }

    func loadMoreImages() {
        page += 1

        imageService.fetchImages(page: page)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = error
                }
            } receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    guard let `self` = self else { return }

                    self.images.append(contentsOf: response.results)
                }
            }
            .store(in: &cancellables)
    }

    func selectImage(_ image: ImageModel) {
        let scene = UIApplication.shared.connectedScenes.first
        if let sceneDelegate : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            sceneDelegate.appCoordinator?.showDetailView(for: image)
        }
    }
}
