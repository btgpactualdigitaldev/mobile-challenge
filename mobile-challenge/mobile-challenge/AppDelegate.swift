//
//  AppDelegate.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 21/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            let nav = UINavigationController()
            let vc = CurrencyConversionViewController()
            nav.viewControllers = [vc]
            nav.navigationBar.isTranslucent = false
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
        return true
    }

}

