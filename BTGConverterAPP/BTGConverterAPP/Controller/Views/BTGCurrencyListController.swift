//
//  BTGCurrencyListController.swift
//  BTGConverterAPP
//
//  Created by Leonardo Maia Pugliese on 16/05/20.
//  Copyright © 2020 Leonardo Maia Pugliese. All rights reserved.
//

import Foundation

protocol CurrencyListController {
    func getCurrencyToCurrencyReceiver()
}

class BTGCurrencyListController: CurrencyListController {
    
    private let networkController = BTGNetworkController.shared
    weak private var currencyListReceiver : CurrencyListDelegate?
    private let localStorage : LocalStorage = BTGLocalStorage()
    
    private var currencyDescriptionList : [CurrencyDescription] = []
    
    init(currencyListReceiver: CurrencyListDelegate) {
        self.currencyListReceiver = currencyListReceiver
    }
    
    func getCurrencyToCurrencyReceiver() {
        currencyDescriptionList = []
        if localStorage.isLocalStorageValid(ofType: .avaliableQuotes) {
            let currencyDescriptionListTemp = localStorage.getAvaliableQuotes()!
            
            for currencyDescription in currencyDescriptionListTemp {
                if !currencyDescriptionList.contains(currencyDescription) {
                    currencyDescriptionList.append(currencyDescription)
                }
            }
            
            currencyListReceiver?.setCurrencyDescriptions(currencyDescriptions: currencyDescriptionList)
        } else {
            networkController.getAvaliableCurrencies {[weak self] result in
                switch result {
                case .success(let avaliableCurrencies):
                    self?.setCurrencyDescription(from: avaliableCurrencies)
                    
                    guard let currencyListReceiver    = self?.currencyListReceiver ,
                        let currencyDescriptionList = self?.currencyDescriptionList else { return }
                    
                    currencyListReceiver.setCurrencyDescriptions(currencyDescriptions: currencyDescriptionList)
                    self?.localStorage.setAvaliableQuotes(self!.currencyDescriptionList)
                case .failure(let error):
                    self?.currencyListReceiver?.showErrorMessage(message: error.rawValue)
                }
            }
        }
    }
    
    func setCurrencyDescription(from avaliableCurrencies: AvaliableCurrencies) {
        for (abbreviation, fullDescription) in avaliableCurrencies.currencies {
            let currencyDescription = CurrencyDescription(abbreviation: abbreviation, fullDescription: fullDescription)
            if !currencyDescriptionList.contains(currencyDescription) {
                currencyDescriptionList.append(CurrencyDescription(abbreviation: abbreviation, fullDescription: fullDescription))

            }
        }
    }
}
