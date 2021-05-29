//
//  CurrencyListViewModel.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import Foundation

class CurrencyListViewModel {
    
    private var manager: CoreDataManager
    
    init() {
        self.manager = CoreDataManager()
    }
    
    func sortArray(by type: TypeSort, currenciesQuotation: [CurrencyQuotation]) -> [[String : [CurrencyQuotation]]] {
        if type == .code {
            let sortedList = currenciesQuotation.sorted { (cQuotarion, cQuotation2) -> Bool in
                return cQuotarion.code < cQuotation2.code
            }
            
            return groupSortedArray(type: type, currencyList: sortedList)
        } else {
            let sortedList = currenciesQuotation.sorted { (cQuotarion, cQuotation2) -> Bool in
                return cQuotarion.currency < cQuotation2.currency
            }
            
            return groupSortedArray(type: type, currencyList: sortedList)
        }
    }
    
    func groupSortedArray(type: TypeSort, currencyList: [CurrencyQuotation]) -> [[String : [CurrencyQuotation]]] {
        var dictCurrencies: [String: [CurrencyQuotation]] = [:]
        
        currencyList.forEach {
            var letter = ""
            
            if type == .code {
                letter = $0.code.prefix(1).uppercased()
            } else {
                letter = $0.currency.prefix(1).uppercased()
            }
            
            if !dictCurrencies.keys.contains(letter) {
                dictCurrencies[letter] = []
            }
            
            dictCurrencies[letter]?.append($0)
        }
        
        return dictCurrencies.map { [$0.key : $0.value] }.sorted { $0.keys.first! < $1.keys.first! }
    }
    
    func filterCurrenciesDict(searchString: String , currenciesDict: [[String : [CurrencyQuotation]]]) -> [CurrencyQuotation] {
        var currencyList: [CurrencyQuotation] = []
        
        for dict in currenciesDict {
            for (_, currencyArray) in dict {
                for currencyQuotation in currencyArray {
                    if currencyQuotation.currency.lowercased().contains(searchString) || currencyQuotation.code.lowercased().contains(searchString) {
                        currencyList.append(currencyQuotation)
                    }
                }
            }
        }
        
        return currencyList
    }
}

extension CurrencyListViewModel {
    func saveEntities(currencyList: [CurrencyQuotation]) {
        manager.create(currenciesQuotation: currencyList)
    }
    
    func fetchEntities(completion: @escaping ((Result<[CurrencyQuotation], CurrencyError>) -> Void)) {
        manager.fetch { (result) in
            switch result {
            case .success(let currentList):
                completion(.success(currentList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
