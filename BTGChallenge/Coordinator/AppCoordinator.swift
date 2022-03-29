//
//  AppCoordinator.swift
//  MarvelCharactersDetails
//
//  Created by Mateus Rodrigues on 24/03/22.
//

import UIKit

protocol Events {
    func callEvent(event: Destinys)
}

protocol CoordinatorProtocol: Events {
    var id: String { get set }
    var childCoordinators: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController? { get set }
    func start()
}

protocol SharedCoordinatorProtocol: CoordinatorProtocol {
    func start(navigation: UINavigationController)
    func start(data: String, navigation: UINavigationController)
}

extension SharedCoordinatorProtocol {
    func start() {}
    func start(data: String, navigation: UINavigationController) {}
}

protocol Destinys {}

protocol AppCoordinatorType {}
enum AppCoordinatorDestinys: Destinys, AppCoordinatorType {
    case home
    case conversion
    case conversionWithAcronym(acronym: String)
    case search
    case removeItem(coordinator: CoordinatorProtocol)
}

class AppCoordinator: CoordinatorProtocol, AppCoordinatorType {
    
    internal var id: String
    internal var childCoordinators: [CoordinatorProtocol]
    private let window: UIWindow
    internal var navigationController: UINavigationController?
    
    init(window: UIWindow, navigationController: UINavigationController = UINavigationController()) {
        self.window = window
        self.childCoordinators = []
        self.id = UUID().uuidString
        self.navigationController = navigationController
    }
    
    func start() {
        childCoordinators = []
        let viewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func callEvent(event: Destinys) {
        if let eventNav = event as? AppCoordinatorDestinys {
            switch eventNav {
            case .home:
                navigationController?.popToRootViewController(animated: true)
            case .conversion:
                guard let navigationController = navigationController else { return }
                let coordinator = ConversionCoordinator()
                childCoordinators.append(coordinator)
                coordinator.start(navigation: navigationController)
                
            case .search:
                guard let navigationController = navigationController else { return }
                let coordinator = SearchCoordinator()
                childCoordinators.append(coordinator)
                coordinator.start(navigation: navigationController)
                
            case .removeItem(let coordinator):
                childCoordinators.enumerated().forEach { index, element in
                    if element.id == coordinator.id {
                        childCoordinators.remove(at: index)
                    }
                }
                
            case .conversionWithAcronym(let acronym):
                guard let navigationController = navigationController else { return }
                let coordinator = ConversionCoordinator()
                childCoordinators.append(coordinator)
                coordinator.start(data: acronym, navigation: navigationController)
                
            }
        }
    }
    
}
