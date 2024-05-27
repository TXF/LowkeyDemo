//
//  PhotoResponse.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Foundation

struct ImageResponse: Codable {
    // MARK: Properties
    
    let results: [ImageModel]

    enum CodingKeys: String, CodingKey {
        case results = "photos"
    }
}

