//
//  MainCoordinator.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 14/07/22.
//

import Foundation
import UIKit

protocol AppCoordinatorConversionDelegate: AnyObject {
    func didSelectCurrency(currency: String, isInitial: Bool)
}

class AppCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController?
    private var window: UIWindow
    var appCoordinatorConversionDelegate: AppCoordinatorConversionDelegate?
    
    init(window: UIWindow, navigationController: UINavigationController? = UINavigationController()) {
        self.window = window
        self.navigationController = navigationController
        self.childCoordinators = []
    }
    
    func start() {
        navigationController?.delegate = self
        goToConversionScreen()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func goToConversionScreen() {
        let child = ConversionCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
        self.appCoordinatorConversionDelegate = child
    }
    
    func goToCurrencyListScreen(isInitial: Bool) {
        let child = CurrenciesCoordinator(navigationController: navigationController)
        childCoordinators.append(child)
        child.currenciesViewControllerDelegate = self
        child.start(isInitial: isInitial)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in
            childCoordinators.enumerated() where coordinator === child {
                childCoordinators.remove(at: index)
                break
        }
    }

}

extension AppCoordinator: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) { return }
        
        if let conversionViewController = fromViewController as? ConversionViewController {
            childDidFinish(conversionViewController.coordinator)
        }
        
        if let currencyListViewController = fromViewController as? CurrenciesViewController {
            childDidFinish(currencyListViewController.coordinator)
        }

    }
}

extension AppCoordinator: CurrenciesViewControllerDelegate {
    func didSelectCurrency(currency: String, isInitial: Bool) {
        appCoordinatorConversionDelegate?.didSelectCurrency(currency: currency, isInitial: isInitial)
    }
    
}
