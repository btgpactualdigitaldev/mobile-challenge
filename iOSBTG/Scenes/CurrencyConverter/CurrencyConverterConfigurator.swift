//
//  CurrencyConverterConfigurator.swift
//  iOSBTG
//
//  Created by Filipe Merli on 10/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

final class CurrencyConverterConfigurator {
    
    static let shared = CurrencyConverterConfigurator()
    
    func configure(viewController: CurrencyConverterViewController) {
        let interactor = CurrencyConverterInteractor()
        let presenter = CurrencyConverterPresenter()
        let router = CurrencyConverterRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
}
