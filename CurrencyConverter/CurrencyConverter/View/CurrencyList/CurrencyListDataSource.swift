//
//  CurrencyListDataSource.swift
//  CurrencyConverter
//
//  Created by Isnard Silva on 02/12/20.
//

import UIKit

class CurrencyListDataSource: NSObject, UITableViewDataSource {
    // MARK: - Properties
    private let currencies: [Currency]
    
    var didSelectCurrency: ((Currency) -> Void)?
    
    
    // MARK: - Initialization
    init(currencies: [Currency]) {
        self.currencies = currencies
        super.init()
    }
    
}


// MARK: - Setup Content Cells
extension CurrencyListDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.Cell.currencyCell, for: indexPath)
        
        let currency = currencies[indexPath.row]
        cell.textLabel?.text = currency.code + " - " + currency.name
        
        return cell
    }
}


// MARK: - UITableViewDelegate
extension CurrencyListDataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedCurrency = currencies[indexPath.row]
        
        didSelectCurrency?(selectedCurrency)
    }
}

