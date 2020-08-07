//
//  CurrenciesViewModel.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import RealmSwift

class CurrenciesListViewModel {
    fileprivate let currencies: Results<Currency>
    var localCurrency: Currency? = nil
    var foreignCurrency: Currency? = nil
    
    enum Behavior {
        case InputLocalCurrency
        case InputForeignCurrency
        case Advance
    }
    
    init() {
        currencies = CurrencyData.getAll()
    }
    
    func getNumberOfRowsInSection(search: String?) -> Int {
        var _currencies = currencies
        if let search = search {
            _currencies = currencies.filter("name LIKE[c] %@ OR abbreviation LIKE[c] %@", "*\(search)*", "*\(search)*")
        }
        return _currencies.count
    }
    
    func getCurrency(at index: Int, search: String?) -> Currency {
        var _currencies = currencies
        if let search = search {
            _currencies = currencies.filter("name LIKE[c] %@ OR abbreviation LIKE[c] %@", "*\(search)*", "*\(search)*")
        }
        return _currencies[index]
    }
    
    func goToExchange() {
        Router.shared.setViewController(viewController: ExchangeViewController(localCurrency: localCurrency!, foreignCurrency: foreignCurrency!))
    }
    
    func isSelectionValid(currenciesTableView: UITableView) -> Bool {
        if let _ = currenciesTableView.indexPathForSelectedRow {
            return true
        } else {
            alert(title: "Atenção!", message: "Selecione uma moeda para continuar")
            return false
        }
    }
    
    func getCurrentBehavior() -> Behavior {
        if localCurrency == nil {
            return .InputLocalCurrency
        } else if foreignCurrency == nil {
            return .InputForeignCurrency
        } else {
            return .Advance
        }
    }
    
    func setCurrency(currency: Currency) {
        if localCurrency == nil {
            localCurrency = currency
        } else {
            foreignCurrency = currency
            saveFavorites()
        }
    }
    
    func clearTableView(tableView: UITableView) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    fileprivate func saveFavorites() {
        let userDefaults = AppUserDefaults()
        userDefaults.putString(key: .LocalCurrency, value: localCurrency!.abbreviation)
        userDefaults.putString(key: .ForeignCurrency, value: foreignCurrency!.abbreviation)
    }
}
