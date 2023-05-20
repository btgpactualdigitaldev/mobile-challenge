//
//  AppDelegate.swift
//  CurrencyConverterBTG
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UINavigationController()
        
        let viewModel: CoinConversionViewModel = CoinConversionViewModel(currencyLayerService: CurrencyLayerService())
        
        let coinConversionViewController: CoinConversionViewController = CoinConversionViewController()
        coinConversionViewController.viewModel = viewModel
        
        navController.pushViewController(coinConversionViewController, animated: true)
        
        window!.rootViewController = navController
        window!.makeKeyAndVisible()
        
        return true
    }
}

