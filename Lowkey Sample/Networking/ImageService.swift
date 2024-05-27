//
//  ImageService.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Foundation
import Combine

protocol ImageServiceProtocol {
    func fetchImages(page: UInt) -> AnyPublisher<ImageResponse, Error>
}

class ImageService: ImageServiceProtocol {
    // MARK: Properties

    private let baseURLPath: String
    private let session: URLSession
    private let queue = DispatchQueue(label: "com.example.LowkeySample.ImageService", qos: .userInitiated)

    // MARK: Initializer:

    init(baseURLPath: String = APIConstants.kServerUrl, session: URLSession = .shared) {
        self.baseURLPath = baseURLPath
        self.session = session
    }

    func fetchImages(page: UInt) -> AnyPublisher<ImageResponse, Error> {
        let urlRequest = buildURLRequest(for: page)

        return Future { [weak self] promise in
            guard let self = self else {
                return promise(.failure(ImageServiceError.unknown))
            }

            self.queue.async {
                let task = self.session.dataTask(with: urlRequest) { data, response, error in
                    if let error = error {
                        promise(.failure(error))
                    } else if let data = data {
                        do {
                            let models = try JSONDecoder().decode(ImageResponse.self, from: data)
                            promise(.success(models))
                        } catch {
                            promise(.failure(error))
                        }
                    } else {
                        promise(.failure(ImageServiceError.unknown))
                    }
                }
                task.resume()
            }
        }
        .eraseToAnyPublisher()
    }

    private func getURL(for page: UInt) -> URL {
        let urlPath = "\(baseURLPath)?per_page=\(APIConstants.kResultsPerPage)&page=\(page)"
        return URL(string: urlPath)!
    }

    private func buildURLRequest(for page: UInt) -> URLRequest {
        var request = URLRequest.init(url: getURL(for: page))
        request.setValue(APIConstants.kApiKey, forHTTPHeaderField: "Authorization")
        return request
    }
}

private enum APIConstants {
    static let kApiKey = "bCc7U431PWJSD6cgqH8reGpRCzx1LGX3VgG3TXt3la2jkJ0EvZDmZn3t"
    static let kServerUrl = "https://api.pexels.com/v1/curated"
    static let kResultsPerPage = 4
}

enum ImageServiceError: Error {
    case unknown
}
