//
//  FeedAssembly.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import Swinject

final class FeedAssembly: Assembly {
    func assemble(container: Container) {
        configure(using: container)
    }

    func configure(using container: Container) {
        container.register(FeedViewModel.self) { resolver in
            let imageService = resolver.resolve(ImageServiceProtocol.self)!
            return FeedViewModel(imageService: imageService)
        }

        container.register(FeedRouter.self) { resolver in
            let feedViewModel = resolver.resolve(FeedViewModel.self)!
            return FeedRouter(viewModel: feedViewModel)
        }
    }
}
