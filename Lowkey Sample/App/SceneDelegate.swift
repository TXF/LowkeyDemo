//
//  SceneDelegate.swift
//  Lowkey Sample
//
//  Created by David on 26.05.2024.
//

import UIKit

final class SceneDelegate: NSObject, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions)
    {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        appCoordinator = AppCoordinator()
        window = appCoordinator?.start(using: windowScene)
    }
}
