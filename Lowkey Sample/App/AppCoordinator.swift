//
//  AppCoordinator.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import SwiftUI
import Swinject

class AppCoordinator: ObservableObject {
    private var feedRouter: FeedRouter?

    func start(using windowScene: UIWindowScene) -> UIWindow {
        feedRouter = DIManager.resolver.resolve(FeedRouter.self)!

        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UIHostingController(rootView: feedRouter?.showView())
        window.makeKeyAndVisible()
        return window
    }

    func showDetailView(for image: ImageModel) {
        feedRouter?.showDetailView(for: image)
    }
}
