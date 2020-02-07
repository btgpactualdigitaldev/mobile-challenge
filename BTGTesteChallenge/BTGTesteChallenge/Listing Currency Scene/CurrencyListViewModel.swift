//
//  CurrencyListViewModel.swift
//  BTGTesteChallenge
//
//  Created by Rafael  Hieda on 2/6/20.
//  Copyright © 2020 Rafael_Hieda. All rights reserved.
//

import Foundation

protocol ListOfCurrencyViewModelProtocol: class {
    var listCurrencyRepository: ListCurrencyRepositoryProtocol? { get }
    var currencyList:[(key: String, value: String)] { get }
    var currencyDictionary: [String : String] { get set }
    var delegate: PresentErrorDelegate { get }
    func totalOfCurrencies() -> Int
    func requestCurrencyList(completion: (() -> ())?)
    
}

class ListOfCurrencyViewModel: ListOfCurrencyViewModelProtocol {
    var currencyList: [(key: String, value: String)] {
        DictionarySortHelper.sortAscending(for: currencyDictionary)
    }
    
    var currencyDictionary: [String : String] = [:]
    
    var delegate: PresentErrorDelegate
    
    var listCurrencyRepository: ListCurrencyRepositoryProtocol?

    init(listCurrencyRepository: ListCurrencyRepositoryProtocol, presentErrorDelegate: PresentErrorDelegate) {
        self.listCurrencyRepository = listCurrencyRepository
        self.delegate = presentErrorDelegate
    }
    
    func totalOfCurrencies() -> Int {
        return currencyDictionary.count
    }
        
    func requestCurrencyList(completion: (() -> ())?) {
        listCurrencyRepository?.fetchListOfCurrency(completionHandler: { [weak self] (result) in
            switch result {
            case .success(let currencyList):
                guard let currencies = currencyList.currencies else { return }
                self?.currencyDictionary = currencies
            case .error(let error):
                self?.delegate.present(error: error.localizedDescription)
            }
            guard let completion = completion else { return }
            completion()
        })
    }

}

class DictionarySortHelper {
    static func sortAscending(for dict: [String:String]) -> [(String,String)] {
        return dict.sorted(by: <)
    }
}
