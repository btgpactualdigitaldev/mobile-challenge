//
//  CurrencyListFactory.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

import UIKit

enum CurrencyListFactory {
    static func make(currencies: [CurrencyEntity],
                     currencyType: CurrencyType,
                     delegate: ChangeCurrencyDelegate) -> UIViewController {
        var viewModel: CurrencyListViewModeling = CurrencyListViewModel(currencies: currencies,
                                                                        currencyType: currencyType)
        viewModel.delegate = delegate
        let viewController = CurrencyListViewController(viewModel: viewModel)
        
        return viewController
    }
}
