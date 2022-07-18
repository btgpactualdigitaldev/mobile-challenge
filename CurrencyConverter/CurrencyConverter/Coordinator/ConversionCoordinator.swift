//
//  ConversionCoordinator.swift
//  CurrencyConverter
//
//  Created by Joao Jaco Santos Abreu (ACT CONSULTORIA EM TECNOLOGIA LTDA – GEDES – MG) on 14/07/22.
//

import Foundation
import UIKit

protocol ConversionCoordinatorDelegate: AnyObject {
    func didSelectCurrency(currency: String, isInitial: Bool)
}

class ConversionCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController?
    var conversionCoordinatorDelegate: ConversionCoordinatorDelegate?
    
    init(navigationController: UINavigationController?) {
        childCoordinators = []
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ConversionScreenFactory.buildConversionScreen()
        vc.coordinator = self
        conversionCoordinatorDelegate = vc
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapInitialCurrency(isInitial: Bool) {
        parentCoordinator?.goToCurrencyListScreen(isInitial: isInitial)
    }
    
    func didTapFinalCurrency(isInitial: Bool) {
        parentCoordinator?.goToCurrencyListScreen(isInitial: isInitial)
    }
    
}

extension ConversionCoordinator: AppCoordinatorConversionDelegate {
    func didSelectCurrency(currency: String, isInitial: Bool) {
        conversionCoordinatorDelegate?.didSelectCurrency(currency: currency, isInitial: isInitial)
    }
    
}
