//
//  PhotoModel.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Foundation

struct ImageModel: Identifiable, Codable {
    // MARK: Properties
    
    let id: Int
    let src: PhotoSource
    let author: String

    enum CodingKeys: String, CodingKey {
        case id
        case author = "photographer"
        case src
    }
}
