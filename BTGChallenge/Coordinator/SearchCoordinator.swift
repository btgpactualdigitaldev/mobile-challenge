//
//  SearchCoordinator.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit

protocol SearchCoordinatorType {}
enum SearchCoordinatorDestinys: Destinys, SearchCoordinatorType {
    case back
    case backToConversion(acronym: String)
}

class SearchCoordinator: SharedCoordinatorProtocol, ConversionCoordinatorType {

    internal var id: String
    internal var childCoordinators: [CoordinatorProtocol]
    internal var navigationController: UINavigationController?

    init() {
        childCoordinators = []
        id = UUID().uuidString
    }
    func start(navigation: UINavigationController) {
        let viewController = SearchViewController()
        self.navigationController = navigation
        navigation.pushViewController(viewController, animated: true)
    }
    
    func callEvent(event: Destinys) {
        if let eventNav = event as? SearchCoordinatorDestinys {
            switch eventNav {
            case .back:
                PeformNavigation.navigate(event: AppCoordinatorDestinys.removeItem(coordinator: self))
                navigationController?.popToRootViewController(animated: true)
            case .backToConversion(let acronym):
                PeformNavigation.navigate(event: AppCoordinatorDestinys.removeItem(coordinator: self))
                navigationController?.popToRootViewController(animated: false)
                PeformNavigation.navigate(event: AppCoordinatorDestinys.conversionWithAcronym(acronym: acronym))
            }
        }
    }
    
}
