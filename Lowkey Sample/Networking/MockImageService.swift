//
//  MockImageService.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Combine

class MockImageService: ImageServiceProtocol {
    var mockImages: [ImageModel] = []
    var resultsPerPage: Int = 4

    func fetchImages(page: UInt) -> AnyPublisher<ImageResponse, Error> {
        let startIndex = Int((page - 1)) * resultsPerPage
        let endIndex = startIndex + resultsPerPage
        let images = Array(mockImages[startIndex..<endIndex])

        return Just(ImageResponse(results: images))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
