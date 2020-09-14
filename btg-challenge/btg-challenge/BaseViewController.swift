//
//  BaseViewController.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import UIKit

class BaseViewController<T: ViewModel>: UIViewController {
    
    var associetedViewModel: T?
    
    override func loadView() {
        super.loadView()
        associetedViewModel = T()
        associetedViewModel?.setViewController(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
