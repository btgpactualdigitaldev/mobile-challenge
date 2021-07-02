//
//  MainCoordinator.swift
//  mobile-challenge-UIKit
//
//  Created by Lucas Fernandez Nicolau on 16/12/20.
//

import UIKit

class MainCoordinator: Coordinator, CurrencyChoosing {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let service = CurrencyLiveRateService(network: APIClient.shared)
        let viewModel = CurrencyConverterViewModel(service: service)
        let vc = CurrencyConverterViewController(coordinator: self,
                                                 viewModel: viewModel)
        
        navigationController.pushViewController(vc, animated: false)
    }

    func chooseCurrency(type: CurrencyConverterViewModel.CurrencyType,
                        onSelect: @escaping (Currency) -> Void) {
        let service = CurrencyListService(network: APIClient.shared)
        let viewModel = CurrencyListViewModel(service: service)
        let vc = CurrencyListViewController(coordinator: self,
                                            viewModel: viewModel,
                                            currencyType: type,
                                            onSelectCurrency: onSelect)

        navigationController.pushViewController(vc, animated: true)
    }

    func goBack() {
        navigationController.popViewController(animated: true)
    }
}
