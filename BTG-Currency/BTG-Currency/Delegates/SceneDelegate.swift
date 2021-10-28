//
//  SceneDelegate.swift
//  BTG-Currency
//
//  Created by Ramon Almeida on 27/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        addDependencies()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

    func addDependencies() {
        Container.shared.register(ListService.self) { _ in
            ListService()
        }
        Container.shared.register(HomeService.self) { _ in
            HomeService()
        }
        Container.shared.register(ListViewModel.self) { resolver in
            ListViewModel(service: resolver.resolve(ListService.self)!)
        }
        Container.shared.register(HomeViewModel.self) { resolver in
            HomeViewModel(service: resolver.resolve(HomeService.self)!)
        }
    }
}

