//
//  AppDelegate.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 08/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let appCoordinator = AppCoordinator(with: window!)
        let _ = appCoordinator.start(with: .push(animated: true))
        return true
    }
}


