//
//  CurrencyListConfigurator.swift
//  iOSBTG
//
//  Created by Filipe Merli on 11/06/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import Foundation

final class CurrencyListConfigurator {
    
    static let shared = CurrencyListConfigurator()
    
    func configure(viewController: CurrencyListViewController) {
        let interactor = CurrencyListInteractor()
        let presenter = CurrencyListPresenter()
        let router = CurrencyListRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
    }
}
