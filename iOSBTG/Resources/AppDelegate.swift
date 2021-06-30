//
//  AppDelegate.swift
//  iOSBTG
//
//  Created by Filipe Merli on 08/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: Properties
        
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let mainTabBarViewController = MainTabBarViewController()
        let mainNavigationViewController = MainNavigationViewController(rootViewController: mainTabBarViewController)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainNavigationViewController
        return true
    }


}

