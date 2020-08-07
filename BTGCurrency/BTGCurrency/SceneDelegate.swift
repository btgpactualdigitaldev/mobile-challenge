//
//  SceneDelegate.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 01/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private(set) static var shared: SceneDelegate?
    
    var window: UIWindow?
    var navigationVC: UINavigationController?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        Self.shared = self
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        navigationVC = UINavigationController()
        navigationVC?.isNavigationBarHidden = true
        window?.rootViewController = navigationVC
        navigationVC?.pushViewController(SplashViewController(), animated: false)
        window?.makeKeyAndVisible()
    }
}
