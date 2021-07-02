//
//  CurrencyListViewModel.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import Foundation
import UIKit

enum SortingType {
    case name
    case code
}

final class CurrencyListViewModel: CurrencyListViewModeling {
    
    typealias Currency = [String: String]
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    weak var didChangeDelegate: CurrencyDidChangeDelegate?
    
    @StorageVariables(key: CurrencyValuesKeys.fromCurrencyCode.rawValue, defaultValue: "USD") 
    private var fromCurrencyCode: String 
    
    @StorageVariables(key: CurrencyValuesKeys.fromCurrencyName.rawValue, defaultValue: "United States Dollar") 
    private var fromCurrencyName: String
    
    @StorageVariables(key: CurrencyValuesKeys.toCurrencyCode.rawValue, defaultValue: "BRL") 
    private var toCurrencyCode: String 
    
    @StorageVariables(key: CurrencyValuesKeys.toCurrencyName.rawValue, defaultValue: "Brazilian Real") 
    private var toCurrencyName: String 
    
    lazy var newCurrencyCode: String = "" {
        didSet {
            switch selectedCase {
            case .beConvertedFrom:
                changeCurrencyValue(oldCode: &fromCurrencyCode, oldName: &fromCurrencyName)
            case .toBeConverted:
                changeCurrencyValue(oldCode: &toCurrencyCode, oldName: &toCurrencyName)
            }
        }
    }
    
    var newCurrencyName: String = ""
    
    private let requestManager: RequestManager
    
    private let coordinator: CurrencyConverterCoordinator
    
    private var selectedCase: SelectCase
    
    private var apiResponse: CurrencyResponseFromList
    
    private var isFilteringFlag: Bool = false
    
    private var response: Currency = [:] {
        didSet {
            convertResponseToCurrencyObject()
        }
    }
    
    private var currenciesObjects: [[CurrencyFromListObject]] = [[]]
    
    private var filteredCurrenciesObjectects: [[CurrencyFromListObject]] = [[]]
    
    var numberOfSections: Int {
        if isFilteringFlag {
            return filteredCurrenciesObjectects.count
        } else {
            return currenciesObjects.count
        }
    }
    
    init(requestManager: RequestManager, coordinator: CurrencyConverterCoordinator, selectedCase: SelectCase, response: CurrencyResponseFromList) {
        self.requestManager = requestManager
        self.coordinator = coordinator
        self.selectedCase = selectedCase
        self.apiResponse = response
        convertoToResponse()
    }
    
    func convertoToResponse() {
        let currency = apiResponse.currencies
        self.response = currency
    }
    
    func swapCurrencies(newCode: String, newName: String) {
        self.newCurrencyName = newName
        self.newCurrencyCode = newCode
        didChangeDelegate?.currencyDidChange()
    }
    
    func numberOfRows(in Section: Int) -> Int{
        if isFilteringFlag {
            return filteredCurrenciesObjectects[Section].count
        } else {
            return currenciesObjects[Section].count
        }
    }
    
    func codeValueAt(indexPath: IndexPath) -> String {
        if isFilteringFlag {
            return filteredCurrenciesObjectects[indexPath.section][indexPath.row].codeString
        } else {
            return currenciesObjects[indexPath.section][indexPath.row].codeString
        }
    }
    
    func nameValueAt(indexPath: IndexPath) -> String {
        if isFilteringFlag {
            return filteredCurrenciesObjectects[indexPath.section][indexPath.row].nameString
        } else {
            return currenciesObjects[indexPath.section][indexPath.row].nameString
        }
    }
    
    func filterContentForSearchText(_ searchText: String, tableView: UITableView) {
        let objects = response.keys.map( {CurrencyFromListObject(codeString: $0, nameString: response[$0] ?? "USD")})
        
        let filteredObjectsByName = objects.filter { (currency: CurrencyFromListObject) -> Bool in
            return currency.nameString.lowercased().contains(searchText.lowercased())
        }
        
        let filteredObjectsByCode = objects.filter { (currency: CurrencyFromListObject) -> Bool in
            return currency.codeString.lowercased().contains(searchText.lowercased())
        }
        
        let filteredObjects = filteredObjectsByName + filteredObjectsByCode
        let cleanedArray = filteredObjects.removingDuplicates()
        
        filteredCurrenciesObjectects = [cleanedArray]
        
        tableView.reloadData()
    }
    
    func sortResponse(by: SortingType, tableView: UITableView) {
        let objects = response.keys.map( {CurrencyFromListObject(codeString: $0, nameString: response[$0] ?? "USD")})
        
        switch by {
        case .code:
            let sortedObjects = objects.sorted(by: { $0.codeString < $1.codeString})
            let result = [sortedObjects]
            self.currenciesObjects = result
            tableView.reloadData()
        case .name:
            let sortedObjects = objects.sorted(by: { $0.nameString < $1.nameString})
            let result = [sortedObjects]
            self.currenciesObjects = result
            tableView.reloadData()
        }
    }
    
    private func changeCurrencyValue(oldCode: inout String, oldName: inout String) {
        oldCode = newCurrencyCode
        oldName = newCurrencyName
        
        coordinator.changeFinished()
    }
    
    private func convertResponseToCurrencyObject() {
        let objects = response.keys.map({CurrencyFromListObject(codeString: $0, nameString: response[$0] ?? "USD")})
        
        let sortedObjects = objects.sorted(by: { $0.codeString < $1.codeString})
        let result = [sortedObjects]
        
        self.currenciesObjects = result
    }    
}

extension CurrencyListViewModel: SearchBarDelegate {
    
    func isFiltering(_ value: Bool) {
        isFilteringFlag = value
    }
}


