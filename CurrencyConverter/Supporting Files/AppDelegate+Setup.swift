//
//  AppDelegate+Setup.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 10/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation
import Swinject
import SwinjectAutoregistration

extension AppDelegate {
    
    internal func setupDependencies() {
        // Services
        container.autoregister(CurrenciesServiceRepository.self, initializer: CurrenciesDataService.init).inObjectScope(ObjectScope.container)
        container.autoregister(CurrenciesPersistenceRepository.self, initializer: CurrenciesPersistence.init).inObjectScope(ObjectScope.container)
        
        // ViewModels
        container.autoregister(CurrenciesViewModel.self, initializer: CurrenciesViewModel.init)
        container.autoregister(ConvertViewModel.self, initializer: ConvertViewModel.init)
        
        // ViewControllers
        container.registerViewController(CurrenciesViewController.self) { r, c in
            c.viewModel = r~>
        }
        container.registerViewController(ConvertViewController.self) { r, c in
            c.viewModel = r~>
        }
    }
}
