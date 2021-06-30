//
//  CurrencyListCoordinator.swift
//  mobile-challenge
//
//  Created by gabriel on 03/12/20.
//

import UIKit

final class CurrencyListCoordinator: Coordinator {
    
    let viewModel: CurrencyListViewModel
    weak var delegate: CurrencyListCoordinatorDelegate?
    
    init(_ currencyList: CurrencyList, for type: CurrencyType, navigationController: UINavigationController) {
        self.viewModel = CurrencyListViewModel(currencyList: currencyList, type: type)
        
        super.init(navigationController: navigationController)
    }
    
    override func start() {
        viewModel.coordinator = self
        let viewController = CurrencyListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension CurrencyListCoordinator {
    func currencySelected(_ currency: Currency) {
        delegate?.currencySelected(currency, for: viewModel.type, from: self)
    }
}
