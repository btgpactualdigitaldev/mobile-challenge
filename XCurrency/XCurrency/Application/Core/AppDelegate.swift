//
//  AppDelegate.swift
//  XCurrency
//
//  Created by Vinicius Nadin on 27/03/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Attributes
    var window: UIWindow?

    // MARK: - Public Methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController
        MainRouter(navigationController: navigationController).present()
        window?.makeKeyAndVisible()
        return true
    }
}

