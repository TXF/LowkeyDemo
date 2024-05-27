//
//  PhotoSource.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Foundation

struct PhotoSource: Codable {
    // MARK: Properties
    
    let originalImageUrl: URL?
    let largeImageURL: URL?
    let mediumImageUrl: URL?

    enum CodingKeys: String, CodingKey {
        case originalImageUrl = "original"
        case mediumImageUrl = "medium"
        case largeImageURL = "large"
    }

    // MARK: Initializer:
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let originalUrlPath = try container.decode(String.self, forKey: .originalImageUrl)
        let largeUrlPath = try container.decode(String.self, forKey: .largeImageURL)
        let mediumUrlPath = try container.decode(String.self, forKey: .mediumImageUrl)

        self.originalImageUrl = URL(string: originalUrlPath)
        self.largeImageURL = URL(string: largeUrlPath)
        self.mediumImageUrl = URL(string: mediumUrlPath)
    }
}

extension PhotoSource {
    init(originalImageUrl: URL?) {
        self.originalImageUrl = originalImageUrl
        self.largeImageURL = nil
        self.mediumImageUrl = nil
    }
}
