//
//  HomeInteractor.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import Foundation

class HomeInteractor: HomeInteractorInput {
    
    weak var output:HomeInteractorOutput?
    var manager: CurrencyManager
    var entites: [CurrencyEntity] = [CurrencyEntity]()
    var localDataInteractor: LocalDataInteractorInput
    
    init(manager: CurrencyManager, localDataInteractor: LocalDataInteractorInput) {
        self.manager = manager
        self.localDataInteractor = localDataInteractor
    }
    func loadRequest() {
        manager.fetchList { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let list):
                strongSelf.currencyQuotes(list: list)
            case .failure(let error):
                strongSelf.connectionFailure(error: error)
            }
        }
    }
    
    func connectionFailure(error: NetworkError) {
        switch error {
        case .noConnection:
            if !localDataInteractor.load().isEmpty{
                self.output?.fetched(entites: localDataInteractor.load())
            }else{
                self.output?.connectionFailure(error: error)
            }
        default:
             self.output?.connectionFailure(error: error)
        }
    }
    
    func currencyQuotes(list: ListCurrenciesModel) {
        manager.currencyQuotes { [weak self] (result) in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
                
            case .success(let listQuotes):
                strongSelf.entites = CurrencyEntityMapper.mappingListCurrency(listCurrency: list, listQuotes: listQuotes)
                strongSelf.output?.fetched(entites: strongSelf.entites)
                strongSelf.localDataInteractor.save(entites: strongSelf.entites)
            case .failure(let error):
                dump(error)
            }
        }
    }
    
    func convert(toCurrency: String, fromCurrency: String, amount: Decimal) {
        guard let entityTo = entites.first(where: { $0.currency == toCurrency}),
            let entityFrom = entites.first(where: { $0.currency == fromCurrency}) else {
                return
        }
        var sum: Decimal  = 0.0
        if entityFrom.currency == "USD" {
            sum = amount / entityTo.quotes
        } else {
            
            let convertDolar =  amount / entityTo.quotes
            sum = convertDolar * entityFrom.quotes
        }
        self.output?.converted(sum: sum)
    }
    
}

