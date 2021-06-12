//
//  Coordinator.swift
//  BTGChallenge
//
//  Created by Gerson Vieira on 08/06/20.
//  Copyright © 2020 Gerson Vieira. All rights reserved.
//

import UIKit

enum Presentation {
    case present(animated: Bool)
    case push(animated: Bool)
    case sheetView(animated: Bool)
}

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var navigation: UINavigationController { get }
    func start(with presentation: Presentation) -> UIViewController
    func addChildCoordinator(_ coordinator: Coordinator)
    func removeChildCoordinator(_ coordinator: Coordinator)
    func popViewController(animated: Bool)
    func dismissViewController(animated:Bool, completion: (() -> Void)?)
}

extension Coordinator {
    func addChildCoordinator(_ coordinator: Coordinator) {
        for element in childCoordinators {
            if element === coordinator {
                return
            }
        }
        childCoordinators.append(coordinator)
    }
    
    func removeChildCoordinator(_ coordinator: Coordinator) {
        guard !childCoordinators.isEmpty else { return }
        for (index, element) in childCoordinators.enumerated() {
            if element === coordinator {
                childCoordinators.remove(at: index)
                return
            }
        }
    }
    
    func popViewController(animated: Bool) {
        navigation.popViewController(animated: animated)
    }
    
    func dismissViewController(animated:Bool, completion: (() -> Void)?) {
        navigation.dismiss(animated: animated, completion: completion)
    }
}
