//
//  BTGTabBarController.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

class BTGTabBarController: UITabBarController {
    var converterViewController: ConverterViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = UIColor(named: .main)
        viewControllers = [createConverterNavigationController(), createListNavigationController()]
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        converterViewController.dismissListViews()
    }
    
    private func createConverterNavigationController() -> UINavigationController {
        converterViewController = ConverterViewController()
        converterViewController.title = ViewControllerTitles.converter.rawValue
        converterViewController.tabBarItem = UITabBarItem(title: TabBarItems.converter.rawValue,
                                                          image: UIImage(named: "Arrow2SquarePath"),
                                                          tag: 0)
        
        return UINavigationController(rootViewController: converterViewController)
    }
    
    private func createListNavigationController() -> UINavigationController {
        let listViewController = ListViewController()
        listViewController.title = ViewControllerTitles.list.rawValue
        listViewController.tabBarItem = UITabBarItem(title: TabBarItems.list.rawValue,
                                                     image: UIImage(named: "ListBullet"),
                                                     tag: 1)
        
        return UINavigationController(rootViewController: listViewController)
    }
}
