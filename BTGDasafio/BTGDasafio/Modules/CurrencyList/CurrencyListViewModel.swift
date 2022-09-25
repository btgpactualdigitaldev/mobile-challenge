//
//  CurrencyListViewModel.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 29/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import UIKit

enum SortBy {
    case name
    case code
}

protocol CurrencyListViewModelDelegate: class {
    func refreshView()
}

class CurrencyListViewModel {
    private var fullListCoins: [Coins]? = []
    private var searchedListCoins: [Coins]? = []
    var hasError: Bool
    private var isLoading: Bool
    var sort: SortBy = .name
    
    weak var deleagte: CurrencyListViewModelDelegate?
    let service: ServiceManager?

    init(hasError: Bool, isLoading: Bool, service: ServiceManager = ServiceManager.sharedInstance) {
        self.hasError = hasError
        self.isLoading = isLoading
        self.service = service
    }

}

// MARK: Variables and functions

extension CurrencyListViewModel {
    var numberOfRows: Int? { return searchedListCoins?.count ?? 0 }
    var isSearchBarEnable: Bool {
        return !isLoading || !(fullListCoins?.isEmpty ?? true)
    }
    
    var cellIdentifier: String { return "currencyCell" }
    var alertTitle: String { return "Não foi possivel completar a operação" }
    var alertMessage: String {
        var message = "Por Favor, tente novamente mais tarde"
        if let value = DataManager.instance.getCurrencies(), !value.isEmpty {
            message = "\(message). Enquanto isso, aproveite o aplicativo com as informações armazenadas da ultima sessão"
        }
        return message
    }
    
    private func getCoins(at index: Int) -> Coins? {
        guard let searchedListCoins = searchedListCoins,
        index < searchedListCoins.count else { return nil }
        return searchedListCoins[index]
    }
    

    func cellTitle(at index: Int) -> String? {
        guard let coin = getCoins(at: index) else { return nil }
        return coin.code
    }
    func cellMessage(at index: Int) -> String? {
        guard let coin = getCoins(at: index) else { return nil }
        return coin.country
    }
    func resetSearchList() {
        searchedListCoins = fullListCoins
        deleagte?.refreshView()
    }
    func filterList(by searchText: String) {
        guard !searchText.isEmpty else {
            deleagte?.refreshView()
            return
        }
        let text = searchText.removeAccents
        searchedListCoins = fullListCoins?.filter({ (coin) -> Bool in
            guard let code = coin.code?.lowercased(),
                let country = coin.country?.lowercased() else { return false }
            return code.removeAccents.contains(text) || country.removeAccents.contains(text)
        })
        
        deleagte?.refreshView()
    }
    
    private func sort(first: Coins?, second: Coins?, type: SortBy) -> Bool {
        return type == .name ? (first?.country ?? "") < (second?.country ?? "") :
            (first?.code ?? "") < (second?.code ?? "")
    }
    
    func sortList(by type: SortBy) {
        fullListCoins?.sort(by: { sort(first: $0, second: $1, type: type) })
        searchedListCoins?.sort(by: { sort(first: $0, second: $1, type: type) })
        deleagte?.refreshView()
    }
}

// MARK: Fetch function

extension CurrencyListViewModel {
    func searchForCurrency() {
        service?.exchangeRateListRequest { [weak self] (currency, err) in
            if let _ = err { self?.hasError = true }
            let values = (currency != nil && currency?.currencies != nil) ? currency?.currencies : DataManager.instance.getCurrencies()
            if let values = values {
                DataManager.instance.setCurrencies(currencies: values)
                for (key, value) in Array(values).sorted(by: { $0.0 < $1.0 }) {
                    self?.fullListCoins?.append(Coins(code: key, country: value))
                }
            }
            self?.isLoading = false
            self?.searchedListCoins = self?.fullListCoins
            self?.deleagte?.refreshView()
        }
    }
}
