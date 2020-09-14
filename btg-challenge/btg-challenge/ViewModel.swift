//
//  BaseViewModel.swift
//  btg-challenge
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import UIKit

protocol ViewModel {
    init()
    var viewController: UIViewController? { get set }
    func setViewController(_ viewController: UIViewController)
}
