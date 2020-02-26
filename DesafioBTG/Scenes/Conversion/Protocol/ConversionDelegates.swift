//
//  ConversionDelegates.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 18/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import UIKit

protocol ConversionBusinessDelegate {
    func setTextSourceButton()
    func setTextToButton()
    func convertCurrency(request: Conversion.Quotes.Request)
}

protocol ConversionDisplayDelegate: class {
    func displaySourceButton(sourceButtonText: String?)
    func displayToButton(toButtonText: String?)
    func displayCurrencies(viewModel: Conversion.Quotes.ViewModel)
    func displayErrorInConvertCurrency()
}

protocol ConversionPresentationDelegate {
    func presentSourceButton(sourceButtonText: String?)
    func presentToButton(toButtonText: String?)
    func presentQuote(quote: Conversion.Quotes.Quote)
    func presentErrorInConvertCurrency()
}

@objc protocol ConversionRoutingDelegate {
    func routeToSelectSourceCurrency(segue: UIStoryboardSegue?)
    func routeToSelectToCurrency(segue: UIStoryboardSegue?)
}

protocol ConversionDataPassing {
    var dataStore: ConversionDataStore? { get }
}

protocol ConversionDataStore {
    var sourceButtonText: String? { get set }
    var toButtonText: String? { get set }
}
