//
//  Coordinator.swift
//  Screens
//
//  Created by Gustavo Amaral on 05/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit

protocol Coordinator {
    func present(from viewController: UIViewController)
    func dismiss(from viewController: UIViewController)
}
