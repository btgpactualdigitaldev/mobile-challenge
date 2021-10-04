//
//  Coordinator.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
