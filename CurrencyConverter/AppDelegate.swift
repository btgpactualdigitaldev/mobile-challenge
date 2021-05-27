//
//  AppDelegate.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import UIKit
import Swinject
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    internal let container = Container()

    private var appCoordinator: AppCoordinator!
    
    func application(_: UIApplication, willFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        setupDependencies()

        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "Ok"

        appCoordinator = AppCoordinator(window: window!, container: container)
        appCoordinator.start()

        window?.makeKeyAndVisible()
        
        return true
    }
}

