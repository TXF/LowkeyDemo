//
//  Lowkey_SampleTests.swift
//  Lowkey SampleTests
//
//  Created by David on 26.05.2024.
//

import XCTest
import Combine
@testable import Lowkey_Sample

class FeedViewModelTests: XCTestCase {
    var viewModel: FeedViewModel!
    var imageService: MockImageService!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        imageService = MockImageService()
        imageService.mockImages = ImageModel.stub
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        imageService = nil
        cancellables = nil
        super.tearDown()
    }

    func testFetchImages() {
        let expectation = XCTestExpectation(description: "Fetch initial images")

        var images: [ImageModel] = []
        viewModel = FeedViewModel(imageService: imageService)
        
        viewModel.$images
            .sink { fetchedImages in
                images = fetchedImages
                if !images.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(images.count, 4)
    }

    func testLoadMoreImages() {
            let expectation = XCTestExpectation(description: "Load more images")
            expectation.expectedFulfillmentCount = 2

            var images: [ImageModel] = []
            imageService.resultsPerPage = 2
            viewModel = FeedViewModel(imageService: imageService)

            viewModel.$images
                .sink { [weak self] fetchedImages in
                    guard let self = self else { return }

                    images = fetchedImages

                    if images.count == 2 {
                        expectation.fulfill()
                        self.viewModel.loadMoreImages()
                    } else if images.count == 4 {
                        expectation.fulfill()
                    }
                }
                .store(in: &cancellables)

            wait(for: [expectation], timeout: 1.0)
            XCTAssertEqual(images.count, 4)
        }
}


