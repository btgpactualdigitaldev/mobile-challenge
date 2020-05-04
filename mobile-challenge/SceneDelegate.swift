//
//  SceneDelegate.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    if let windowScene = scene as? UIWindowScene {
      let window = UIWindow(windowScene: windowScene)
      let navController = UINavigationController(rootViewController: ResultViewController())
      window.rootViewController = navController
      self.window = window
      window.makeKeyAndVisible()
    }
    if #available(iOS 13.0, *) {
      self.window?.overrideUserInterfaceStyle = .light
    }
    guard let _ = (scene as? UIWindowScene) else { return }
  }
  
}

