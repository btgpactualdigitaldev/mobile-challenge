//
//  AppCoordinator.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import UIKit

protocol BTGViewModelProtocol {
    var coordinatorDelegate: AppCoordinatorDelegate? { get set }
}

protocol AppCoordinatorDelegate: AnyObject {
    func openLists(_ viewModel: BTGViewModelProtocol, currencyClicked: @escaping ((String, String)) -> Void)
    func popViewController()
    func showAlert(_ viewModel: BTGViewModelProtocol, message: String)
}

final class AppCoordinator {
    
    let window: UIWindow
    var view: BTGConversorViewController?
    var navigationController: UINavigationController?
    
    required init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let service = ConversorService()
        let viewModel = BTGConversorViewModel(service)
        viewModel.coordinatorDelegate = self
        view = BTGConversorViewController(viewModel)
        navigationController = UINavigationController(rootViewController: view!)
        window.rootViewController = navigationController!
        window.makeKeyAndVisible()
        
    }
    
    func stop() {
        view = nil
    }
    
}

extension AppCoordinator: AppCoordinatorDelegate {
    func openLists(_ viewModel: BTGViewModelProtocol, currencyClicked: @escaping ((String, String)) -> Void) {
        guard let nav = navigationController else { return }
        let service = ConversorService()
        let viewModel = BTGCurrenciesViewModel(service)
        viewModel.coordinatorDelegate = self
        viewModel.didSelectCurrency = currencyClicked
        let vc = BTGCurrenciesViewController(viewModel)
        nav.pushViewController(vc, animated: true)
    }
    
    func popViewController() {
        guard let nav = navigationController else { return }
        nav.popViewController(animated: true)
    }
    
    func showAlert(_ viewModel: BTGViewModelProtocol, message: String) {
        let alert = UIAlertController(title: "Oppsss", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        view?.present(alert, animated: true, completion: nil)
        
    }
}
