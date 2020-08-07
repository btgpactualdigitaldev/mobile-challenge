//
//  SplashViewController.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    let viewModel = SplashViewModel(currencyClient: CurrencyClient(), userDefaults: AppUserDefaults(), networkHelper: NetworkHelper())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.checkLastUpdate()
    }

}
