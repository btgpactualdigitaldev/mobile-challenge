//
//  SecondViewController.swift
//  Currency Converter
//
//  Created by Pedro Fonseca on 29/08/20.
//  Copyright © 2020 Pedro Bernils. All rights reserved.
//

import UIKit
import RealmSwift

class SecondViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var currencies = [Currency]()
    var currencyPosition = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.startAnimating()
        Currency.listCurrencies { (receivedCurrencies, error) in
            
            if self.activityIndicator.isAnimating {
                self.activityIndicator.stopAnimating()
            }
            
            let realm = try! Realm()
            var currencyList: Results<Currency>
            
            if (error != nil) {
                self.showSimpleAlert(title: error!.userInfo[NSLocalizedDescriptionKey] as! String,
                                     message: error!.userInfo[NSLocalizedRecoverySuggestionErrorKey] as! String)
                
                currencyList = realm.objects(Currency.self).filter("active = true AND quoteExists = true").sorted(byKeyPath: "shortName")
            } else {
                currencyList = realm.objects(Currency.self).filter("active = true").sorted(byKeyPath: "shortName")
            }
            
            self.populateTableView(currencyList: currencyList)
        }
    }
    
    func populateTableView(currencyList: Results<Currency>) {
        
        if (currencyList.count < 1) {
            tableView.isHidden = true
            errorMessage.isHidden = false
        } else {
            tableView.isHidden = false
            errorMessage.isHidden = true
        }
        
        currencies.removeAll()
        currencies.append(contentsOf: currencyList)
        
        tableView.reloadData()
    }
    
    func searchFor(text: String) {
                
        let realm = try! Realm()
        
        let currencyList = realm.objects(Currency.self).filter("shortName CONTAINS[c] %@ OR longName CONTAINS[c] %@", text, text).sorted(byKeyPath: "shortName")
        populateTableView(currencyList: currencyList)
    }
}

// MARK: - Extension
extension SecondViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyTableViewCell
        let currency = self.currencies[indexPath.row]
        
        cell.shortName.text = currency.shortName
        cell.longName.text = currency.longName

        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = currencies[indexPath.row]
        let user = User.getMainUser()
        if let user = user {
            user.changeCurrency(currencyPosition, currency.shortName!)
        }
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update"), object: nil)
        }
    }
}

extension SecondViewController: UISearchBarDelegate {
        
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchFor(text: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
