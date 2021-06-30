//
//  MainNavigationController.swift
//  iOSBTG
//
//  Created by Filipe Merli on 11/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

final class MainNavigationViewController: UINavigationController {

    // MARK: - Properties
    
    
    // MARK: - ViewController life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigation()
    }
    
    // MARK: - Class Functions

    private func setUpNavigation() {
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .groupTableViewBackground
    }
    
}
