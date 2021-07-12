//
//  TableCurrencyVM.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 27/11/20.
//

import Foundation
import UIKit

//MARK: -Enum
enum CurrencyViewModelReceiver {
    case currencyOrigin
    case currencyDestiny
}

//MARK: -Protocols
protocol CurrencyDataVMDelegate: class {
    func didReceiveCurrencies()
}

protocol ReceiverDataDelegate: class {
    func didReceiveData(_ nameCurrency:String, _ value: Double, _ to: CurrencyViewModelReceiver)
}

//MARK: -Class
class TableCurrencyVM{
    
    var networkManager = NetworkManager()
    var quotes = [String:Double]()
    var quotesArray = [String]()
    weak var delegate: CurrencyDataVMDelegate?
    weak var delegateData: ReceiverDataDelegate?
    var receptorData: CurrencyViewModelReceiver = .currencyOrigin
    
    
    //MARK: -Init
    init() {
        networkManager.delegate = self
        networkManager.fetchCurrency()
    }
}

//MARK: -Extensions
extension TableCurrencyVM: NetworkManagerDelegate{
    func didGetCurrencyList(_ networkManager: NetworkManager, _ currencyModel: CurrencyModel) {
        
        DispatchQueue.main.async { [weak self] in
            self?.quotesArray = Array(currencyModel.quotes.keys).sorted(by: <)
            self?.quotes = currencyModel.quotes
            self?.delegate?.didReceiveCurrencies()
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
