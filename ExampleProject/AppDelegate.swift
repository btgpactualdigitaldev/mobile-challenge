//
//  AppDelegate.swift
//  ExampleProject
//
//  Created by Lucas Mathielo Gomes on 02/09/20.
//  Copyright © 2020 Lucas Mathielo Gomes. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let nav = UINavigationController(rootViewController: CurrencyExchangeViewController())
        nav.navigationBar.barTintColor = .black
        nav.navigationBar.tintColor = .white
        nav.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        nav.navigationBar.isTranslucent = false
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -1000.0, vertical: 0.0), for: .default)
        
        window.rootViewController = nav
        window.makeKeyAndVisible()
        
        return true
    }

}

