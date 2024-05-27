//
//  ImageModel.swift
//  Lowkey SampleTests
//
//  Created by David on 27.05.2024.
//

import Foundation
@testable import Lowkey_Sample

extension ImageModel {
    static var stub: [ImageModel] {
        [
            ImageModel(id: 1,
                       src: PhotoSource(originalImageUrl: URL(string:"https://example.com/image1.jpg")),
                       author: "John Doe"
                      ),
            ImageModel(id: 2,
                       src: PhotoSource(originalImageUrl: URL(string:"https://example.com/image2.jpg")),
                       author: "Lara Doe"
                      ),
            ImageModel(id: 3,
                       src: PhotoSource(originalImageUrl: URL(string:"https://example.com/image3.jpg")),
                       author: "Test User"
                      ),
            ImageModel(id: 4,
                       src: PhotoSource(originalImageUrl: URL(string:"https://example.com/image4.jpg")),
                       author: "Stub User"
                      ),
            ImageModel(id: 5,
                       src: PhotoSource(originalImageUrl: URL(string:"https://example.com/image5.jpg")),
                       author: "Unknown"
                      ),

        ]
    }
}
