//
//  CustomNavigationController.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 21/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: UIColor.darkText]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
    }
}
