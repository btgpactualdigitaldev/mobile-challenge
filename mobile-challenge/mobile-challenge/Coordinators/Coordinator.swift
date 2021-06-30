//
//  Coordinator.swift
//  mobile-challenge
//
//  Created by gabriel on 03/12/20.
//

import UIKit

/**
Base class for Coordinators
*/
class Coordinator: NSObject {
    
    private(set) var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        preconditionFailure("Start method must be overridden")
    }
            
    func addChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: {$0 === coordinator})
    }
}
