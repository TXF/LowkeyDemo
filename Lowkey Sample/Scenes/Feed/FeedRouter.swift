//
//  FeedRouter.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import SwiftUI
import Swinject

class FeedRouter: ObservableObject {
    @Published var isShowingDetailView = false
    var detailView: DetailView?
    
    private let viewModel: FeedViewModel

    // MARK: Initializer:
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
    }

    func showView() -> some View {
        FeedView(viewModel: viewModel, router: self)
    }

    func showDetailView(for image: ImageModel) {
        let detailViewModel = DIManager.resolver.resolve(DetailViewModel.self)!
        detailViewModel.imageModel = image
        detailView = DetailView(viewModel: detailViewModel)
        isShowingDetailView = true
    }
}
