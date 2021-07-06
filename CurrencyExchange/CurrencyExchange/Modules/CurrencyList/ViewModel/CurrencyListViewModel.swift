//
//  CurrencyListViewModel.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import Foundation
import CoreData

protocol CurrencyListViewModelDelegate: class {
    func willLoadData()
    func didLoadData(message: String?)
}


class CurrencyListViewModel {
    
    var currencyButtonType: CurrencyButtonType
    weak var delegate: CurrencyListViewModelDelegate?
    var currencies: [Currency]
    var currencyDAO: CurrencyDAO
    
    init(currencyButtonType: CurrencyButtonType, context: NSManagedObjectContext){
        self.currencyButtonType = currencyButtonType
        self.currencies = []
        self.currencyDAO = CurrencyDAO(context: context)
    }
    
    func loadData(){
        if NetworkMonitor.shared.isConnected {
            self.loadDataWhenNetworkIsAvailable()
        }else {
            self.loadDataWhenNetworkIsNotAvailable()
        }
    }
    
    private func loadDataWhenNetworkIsNotAvailable(){
        self.delegate?.willLoadData()
        do {
            try self.currencyDAO.fetchWithPredicate(nil, withSortDescriptors: nil) { (currencies) in
                self.currencies = currencies
                self.delegate?.didLoadData(message: nil)
            }
        }catch {
            self.delegate?.didLoadData(message: CoreDataError.cannotBeFetched.description)
        }
    }

    
    private func loadDataWhenNetworkIsAvailable(){
        self.delegate?.willLoadData()
        
        let currencyClient = CurrencyClient(session: URLSession.shared)
        
        currencyClient.getLiveCurrencies { [weak self] (resultOfLiveCurrencies) in
            guard let self = self else { return }
            switch resultOfLiveCurrencies {
            
            case .success(let liveCurrencies):
                
                currencyClient.getListOfCurrencies { [weak self] (result) in
                    guard let self = self else { return }
                    switch result {
        
                    case .success(let currencies):
                        guard let currencies = currencies.currencies else { return }
                        
                        for (code, name) in currencies {

                            if let currencyValue = liveCurrencies.quotes?["USD\(code)"]{
                                
                                let currency = Currency(name: name, code: code, value: Double(currencyValue))
                                self.currencies.append(currency)
                                
                                let predicate = NSPredicate(format: "code == %@", currency.code)
                                
                                self.currencyDAO.createWithoutRepetitionWithCurrency(currency, withPredicate: predicate) {
                                    print("Saved")
                                }
                            }
                            
                        }
                        
                        self.delegate?.didLoadData(message: nil)
                    case .failure(let error):
                        self.delegate?.didLoadData(message: error.description)
        
                    }
                }
                
            case .failure(let error):
                self.delegate?.didLoadData(message: error.description)
            }
        }
    }
    
    
}
