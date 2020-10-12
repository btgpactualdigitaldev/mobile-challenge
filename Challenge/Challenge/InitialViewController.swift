//
//  ViewController.swift
//  Challenge
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import UIKit

class InitialViewController: UITabBarController {

    private let firstViewController = AmountConversionViewController()
    private let secondViewController = AvailableCurrenciesViewController()
    
    override func viewDidLoad() {
        firstViewController.tabBarItem = UITabBarItem(title: "Conversion", image: UIImage(systemName: "arrow.2.squarepath"), tag: 0)
        secondViewController.tabBarItem = UITabBarItem(title: "Currency List", image: UIImage(systemName: "list.bullet"), tag: 1)
        
        let tabBarList = [firstViewController, secondViewController]
        viewControllers = tabBarList
    }

}

