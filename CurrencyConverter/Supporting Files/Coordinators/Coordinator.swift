//
//  Coordinator.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 11/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import Swinject
import UIKit

protocol Coordinator: AnyObject {
    var container: Container { get }
    func start()
}

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get }
}
