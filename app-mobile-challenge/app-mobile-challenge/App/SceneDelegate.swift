//
//  SceneDelegate.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 27/11/20.
//

import UIKit

// Class

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // Properties

    var window: UIWindow?

    private lazy var navegationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        return navigationController
    }()

    private lazy var coordinator = CurrencyCoordinator(navegationController)

    // Methods

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navegationController
        window?.makeKeyAndVisible()
        coordinator.start()
    }
}

