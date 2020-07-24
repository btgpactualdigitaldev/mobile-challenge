//
//  AppDelegate.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions
        launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BTGTabBarController()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()

        return true
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = UIColor(named: .main)
    }
}
