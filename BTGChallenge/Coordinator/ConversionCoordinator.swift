//
//  ConversionCoordinator.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit

protocol ConversionCoordinatorType {}
enum ConversionCoordinatorDestinys: Destinys, ConversionCoordinatorType {
    case search
    case back
}

class ConversionCoordinator: SharedCoordinatorProtocol, ConversionCoordinatorType {
    
    internal var id: String
    internal var childCoordinators: [CoordinatorProtocol]
    internal var navigationController: UINavigationController?

    init() {
        childCoordinators = []
        id = UUID().uuidString
    }
    
    func start(navigation: UINavigationController) {
        let viewController = ConversionViewController()
        self.navigationController = navigation
        navigation.pushViewController(viewController, animated: true)
    }
    
    func start(data: String, navigation: UINavigationController) {
        let viewController = ConversionViewController(acronym: data)
        self.navigationController = navigation
        navigation.pushViewController(viewController, animated: true)
    }
    
    func callEvent(event: Destinys) {
        if let eventNav = event as? ConversionCoordinatorDestinys {
            switch eventNav {
            case .back:
                PeformNavigation.navigate(event: AppCoordinatorDestinys.removeItem(coordinator: self))
                navigationController?.popToRootViewController(animated: true)
            case .search:
                PeformNavigation.navigate(event: AppCoordinatorDestinys.removeItem(coordinator: self))
                navigationController?.popToRootViewController(animated: false)
                PeformNavigation.navigate(event: AppCoordinatorDestinys.search)
            }
        }
    }
    
}
