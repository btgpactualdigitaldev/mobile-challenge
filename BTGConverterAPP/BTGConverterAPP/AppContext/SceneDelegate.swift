//
//  SceneDelegate.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 15/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabbar()
        window?.makeKeyAndVisible()
        
        configureNavigationBar()
    }
    
    func createBTGCurrencyConverterVC() -> UIViewController {
        let currencyConverterVC = BTGCurrencyConverterVC()
        currencyConverterVC.title = BTGSceneDelegateConstants.converterViewTitle.rawValue
        currencyConverterVC.tabBarItem = UITabBarItem(
            title: BTGSceneDelegateConstants.tabBarConverterItemTitle.rawValue,
            image: UIImage(systemName: SFSymbolsConstants.globe.rawValue), tag: 0)
        return currencyConverterVC
    }
    
    func createBTGCurrencyListVC() -> UINavigationController {
        let currencyListVC = BTGCurrencyListVC()
        let navController = UINavigationController(rootViewController: currencyListVC)
        currencyListVC.title = BTGSceneDelegateConstants.listViewTitle.rawValue
        currencyListVC.tabBarItem = UITabBarItem(
            title: BTGSceneDelegateConstants.tabBarListItemTitle.rawValue,
            image: UIImage(systemName: SFSymbolsConstants.list.rawValue), tag: 1)
        return navController
    }
    
    func createTabbar() -> UITabBarController {
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .systemGreen
        tabbar.viewControllers = [createBTGCurrencyConverterVC(),createBTGCurrencyListVC()]
        return tabbar
    }
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
    
    
}

