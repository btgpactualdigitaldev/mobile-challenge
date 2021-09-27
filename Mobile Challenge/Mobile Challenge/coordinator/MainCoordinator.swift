//
//  MainCoordinator.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 25/09/21.
//

import UIKit

class MainCoordinator: Coordinator {
   
    // MARK: - Public properties
    
    weak var currentNavigationController: UINavigationController!
    
    // MARK: - Public methods
    
    func start(navigationController: UINavigationController) {
        let converterController = ConverterController.instantiate(storyboardName: Constants.converterStoryboardName.rawValue, bundle: Bundle.main)
        converterController.coordinator = self
        converterController.viewModel = ConverterViewModel(converterUseCase: ConverterUseCase())
        converterController.title = Constants.converterScreenTitle.rawValue
        currentNavigationController = navigationController
        currentNavigationController.pushViewController(converterController, animated: false)
    }
    
    func goToCurrencyList(delegate: SelectCurrencyDelegate) {
        let currencyListController = CurrencyListController.instantiate(storyboardName: Constants.currencyListStoryboardName.rawValue, bundle: Bundle(for: type(of: self)))
        currencyListController.coordinator = self
        currencyListController.delegate = delegate
        currencyListController.viewModel = CurrencyListViewModel(currencyListUseCase: ListCurrenciesUseCase())
        currencyListController.title = Constants.currencyListScreenTitle.rawValue
        currentNavigationController.pushViewController(currencyListController, animated: true)
    }

    func back() {
        currentNavigationController.popViewController(animated: true)
    }

}

