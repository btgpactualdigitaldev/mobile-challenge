//
//  Coordinator.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 08/12/20.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}
