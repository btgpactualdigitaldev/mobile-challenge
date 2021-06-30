//
//  MainTabBarViewController.swift
//  iOSBTG
//
//  Created by Filipe Merli on 11/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }

    // MARK: - Class functions
    
    private func configView() {
        let currencyConverterViewController = CurrencyConverterViewController()
        let tabBar1 = UITabBarItem(title: "Converter", image: UIImage(imageLiteralResourceName: "converter-icon"), tag: 0)
        currencyConverterViewController.tabBarItem = tabBar1
        let currencyListViewController = CurrencyListViewController()
        let tabBar2 = UITabBarItem(title: "List", image: UIImage(imageLiteralResourceName: "list-icon"), tag: 1)
        currencyListViewController.tabBarItem = tabBar2
        self.viewControllers = [currencyConverterViewController, currencyListViewController]
    }
    
}
