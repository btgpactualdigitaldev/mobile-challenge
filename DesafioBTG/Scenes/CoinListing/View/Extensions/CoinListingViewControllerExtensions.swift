//
//  CoinListingViewControllerExtensions.swift
//  DesafioBTG
//
//  Created by Robson Moreira on 20/02/20.
//  Copyright © 2020 Robson Moreira. All rights reserved.
//

import UIKit

extension CoinListingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = self.viewModel, let currencySelected = self.currencySelected {
            let currency = viewModel.currencies[indexPath.row]
            self.interactor.selected(currency: currency, from: currencySelected)
        }
    }
    
}

extension CoinListingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = self.viewModel else { return 0 }
        return viewModel.countOfCurrencies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.classId, for: indexPath) as? CurrencyTableViewCell
        
        guard let currencyCell = cell, let viewModel = self.viewModel else { return UITableViewCell() }
        
        let currency = viewModel.currencies[indexPath.row]
        
        if let flag = IsoCountries.flag(currencyCode: currency.currencyCode) {
            currencyCell.countryImageView.image = flag.image(imageSize: 40)
        }
        
        currencyCell.codeLabel.text = currency.currencyCode
        currencyCell.nameLabel.text = currency.currencyCountry
        
        return currencyCell
    }
    
}

extension CoinListingViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        self.interactor.searchCurrency(text: text)
    }
    
}


extension CoinListingViewController: CoinListingDisplayDelegate {
    
    func displayCurrencies(viewModel: CoinListing.Currencies.ViewModel) {
        self.currenciesActivityIndicator.isHidden = true
        self.currenciesActivityIndicator.stopAnimating()
        
        self.viewModel = viewModel
        
        self.currenciesTableView.reloadData()
        self.currenciesTableView.isHidden = false
    }
    
    func displayErrorInFetchCurrencies() {
        self.currenciesActivityIndicator.isHidden = true
        self.currenciesActivityIndicator.stopAnimating()
        
        self.showAlert(title: "Erro", message: "Erro ao obter a lista de Moedas. Por favor tente novamente mais tarde.") { (_) in
            self.router.routeToConversion(segue: nil)
        }
    }
    
    func displaySourceCurrency() {
        self.router.routeToConversionSourceCurrency(segue: nil)
    }
    
    func displayToCurrency() {
        self.router.routeToConversionToCurrency(segue: nil)
    }
    
    func setCurrencySelected(currencySelected: CurrencySelected?) {
        self.currencySelected = currencySelected
    }
    
}
