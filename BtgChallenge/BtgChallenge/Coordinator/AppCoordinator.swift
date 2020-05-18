//
//  AppCoordinator.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 10/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    
    // MARK: - Properties
    
    var parentCoordinator: Coordinator?
    
    let window: UIWindow
    lazy var navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        navigationController.navigationBar.barTintColor = UIColor.darkBlue
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.prefersLargeTitles = true
        
        let titleAttrs = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.titleTextAttributes = titleAttrs
        navigationController.navigationBar.largeTitleTextAttributes = titleAttrs
        
        return navigationController
    }()
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let provider = HTTPProvider<CurrencyRouter>()
        let localStorage = LocalStorageImpl()
        let repository = CurrencyRepositoryImpl(provider: provider, localStorage: localStorage)
        let viewModel = CoinConvertViewModel(repository: repository)
        let viewController = CoinConvertViewController(viewModel: viewModel, coordinator: self)
        viewModel.viewController = viewController
        
        navigationController.pushViewController(viewController, animated: false)
        
        window.rootViewController = navigationController
        window.backgroundColor = .darkBlue
        window.makeKeyAndVisible()
    }
}

extension AppCoordinator: CoinConvertCoordinatorDelegate {
    func showCoinList(delegate: CoinListViewControllerDelegate?) {
        let provider = HTTPProvider<CurrencyRouter>()
        let localStorage = LocalStorageImpl()
        let repository = CurrencyRepositoryImpl(provider: provider, localStorage: localStorage)
        let viewModel = CoinListViewModel(repository: repository)
        let coinListViewController = CoinListViewController(viewModel: viewModel, coordinator: self, delegate: delegate)
        viewModel.viewController = coinListViewController
        
        navigationController.pushViewController(coinListViewController, animated: true)
    }
}

extension AppCoordinator: CoinListCoordinatorDelegate {
    func close() {
        navigationController.popViewController(animated: true)
    }
}
