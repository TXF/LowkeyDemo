//
//  FeedRouterTests.swift
//  Lowkey SampleTests
//
//  Created by David on 27.05.2024.
//

import XCTest
import SwiftUI
@testable import Lowkey_Sample

class FeedRouterTests: XCTestCase {
    var feedRouter: FeedRouter!
    var viewModel: FeedViewModel!
    var mockImageService: MockImageService!

    override func setUp() {
        super.setUp()
        mockImageService = MockImageService()
        mockImageService.mockImages = ImageModel.stub
        viewModel = FeedViewModel(imageService: mockImageService)
        feedRouter = FeedRouter(viewModel: viewModel)
    }

    override func tearDown() {
        feedRouter = nil
        viewModel = nil
        mockImageService = nil
        super.tearDown()
    }

    func testShowFeedView() {
        let feedView = feedRouter.showView()
        XCTAssertNotNil(feedView)
    }

    func testShowDetailView() {
        let image = ImageModel.stub.first!
        feedRouter.showDetailView(for: image)
        XCTAssertNotNil(feedRouter.detailView)
    }
}
