//
//  CurrenciesVC.swift
//  Desafio BTG
//
//  Created by Vinícius Brito on 25/05/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import UIKit

/*
 Delegate in order to update previous controller with the chosen currency.
 */
protocol CurrenciesVCDelegate: class {
    func updateTextFields(text: String, bool: Bool)
}

class CurrenciesVC: UIViewController {
    
    weak var delegate: CurrenciesVCDelegate?

    @IBOutlet weak var currenciesTableView: UITableView!
    
    var currencyList = Currency()
    var array = [String]()
    var sorted = [String]()
    var filteredCurrency = [String]()
    var isFromCurrency: Bool = false
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }

    let searchController = UISearchController(searchResultsController: nil)
    let cellIdentifier = "CurrencyCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
        setupTableView(tableView: currenciesTableView)
        checkForData()
    }
    
    // MARK: - <Methods>

    /*
     Configure TableView.
     */
    func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    /*
     Sort data to populate TableView.
    */
    func checkForData() {
        
        for (key, value) in self.currencyList.dict {
            array.append("\(key) \(value)")
        }
        
       sorted = array.sorted(by: { $0 < $1 })

        currenciesTableView.reloadData()
    }
    
    /*
     Configure SearchController.
     */
    private func setUpSearchController () {
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = UIColor.black
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchController.searchBar.tintColor = UIColor(red: 182.0/255, green: 219.0/255, blue: 196.0/255, alpha: 1.0)
        definesPresentationContext = true
        searchController.searchBar.placeholder = "Search for a currency.."
       
        searchController.searchBar.sizeToFit()
        
        currenciesTableView.tableHeaderView = searchController.searchBar
    }
    
    /*
     Get the typed value then assign to array of filtered currencies and reload TableView.
     */
    func filterContentForSearchText(_ searchText: String) {
        filteredCurrency = sorted.filter { (list: String) -> Bool in
        return (list.lowercased() as AnyObject).contains(searchText.lowercased())
      }
        currenciesTableView.reloadData()
      
    }
}

// MARK: - <TableView>

extension CurrenciesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering {
            return filteredCurrency.count
        }
        return sorted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CurrencyCell {
            var currency = self.sorted[indexPath.row]
                        
            if isFiltering {
                currency = filteredCurrency[indexPath.row]
            }
            
            cell.setup(currency: currency)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if isFiltering {
            currenciesTableView.deselectRow(at: indexPath, animated: true)
            delegate?.updateTextFields(text: filteredCurrency[indexPath.row], bool: isFromCurrency)
            self.navigationController?.popViewController(animated: true)
        } else {
            currenciesTableView.deselectRow(at: indexPath, animated: true)
            delegate?.updateTextFields(text: sorted[indexPath.row], bool: isFromCurrency)
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
}

// MARK: - <UISearchControllerDelegate>

extension CurrenciesVC: UISearchResultsUpdating {
    
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
    
}
