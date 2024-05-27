//
//  FeedView.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import SwiftUI
import Kingfisher
import PullToRefreshSwiftUI

struct FeedView : View {
    @ObservedObject private var viewModel: FeedViewModel
    @ObservedObject private var router: FeedRouter

    // MARK: Initializer:

    public init(viewModel: FeedViewModel, router: FeedRouter) {
        self.viewModel = viewModel
        self.router = router
    }

    var body: some View {
        NavigationStack {
            VStack {
                PullToRefreshListView(
                    options: PullToRefreshListViewOptions(pullToRefreshAnimationHeight: 100,
                                                          animationDuration: 0.3,
                                                          animatePullingViewPresentation: true,
                                                          animateRefreshingViewPresentation: true),
                    isPullToRefreshEnabled: true,
                    isRefreshing: $viewModel.isRefreshing,
                    onRefresh: {
                        viewModel.fetchImages(isRefresh: true)
                    },
                    animationViewBuilder: { (state) in
                        switch state {
                        case .idle:
                            Color.clear

                        case .pulling, .refreshing, .finishing:
                            ProgressView().progressViewStyle(.circular)
                        }
                    },
                    contentViewBuilder: { _ in
                        ForEach(viewModel.images, id:\.id) { image in
                            ImageRow(image: image)
                                .onTapGesture {
                                    viewModel.selectImage(image)
                                }
                        }
                        ProgressView()
                            .onAppear {
                                viewModel.loadMoreImages()
                            }
                    })
            }
            .navigationDestination(isPresented: $router.isShowingDetailView, destination: {
                router.detailView
            })
            .navigationBarTitle("Image Feed", displayMode: .inline)
            .navigationBarTitleDisplayMode(.inline)
            .onViewDidLoad {
                viewModel.fetchImages()
            }
        }

    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView(viewModel: FeedViewModel(imageFetchingViewModel: MockImageFetchingViewModel()), router: MockFeedRouter())
//    }
//}
