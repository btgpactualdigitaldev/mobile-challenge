//
//  AppDelegate.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = InitialViewController()
        window?.rootViewController?.navigationController?.isNavigationBarHidden = true
        window?.makeKeyAndVisible()

        return true
    }

}

