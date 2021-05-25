//
//  ListCurrenciesViewController.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 19/05/21.
//

import UIKit

class CurrencyListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var currenciesList: [Currency] = []
    var filteredCurrenciesList: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        super.hideNavigationBar()
        super.hideKeyboardWhenTappedAround()
        
        self.configureTableView()
        self.configureSearchBar()
        self.loadCurrencies()
    }
    
    private func configureTableView() {
        self.tableView.register(UINib(nibName: Constants.CELL_IDENTIFIER, bundle: nil),
                                forCellReuseIdentifier: Constants.CELL_IDENTIFIER)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.layer.cornerRadius = Constants.CORNER_RADIUS
    }
    
    private func configureSearchBar() {
        self.searchBar.delegate = self        
        self.searchBar.searchTextField.font = UIFont(name: Constants.FONT_NAME,
                                                     size: Constants.PICKER_VIEW_FONT_SIZE)
        self.searchBar.searchTextField.textColor = UIColor.white
        self.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Constants.PLACEHOLDER_SEARCHBAR, attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        
        self.searchBar.layer.cornerRadius = Constants.CORNER_RADIUS
    }    
    
    private func loadCurrencies() {
        if let tempCurrenciesList = UserDefaultsPersistenceManager().getCurrencies(withKey: Constants.LIST_CURRENCIES_KEY) {
            self.currenciesList = tempCurrenciesList
            self.filteredCurrenciesList = tempCurrenciesList
        } else {
            if NetworkManager().hasInternetConnection() {
                NetworkManager().fetchCurrenciesList { [weak self] currencies in
                    if let currencies = currencies {
                        if currencies.count == 0 {
                            return
                        } else {
                            self?.currenciesList = currencies.sorted { $0.code < $1.code }
                            self?.filteredCurrenciesList = self?.currenciesList ?? []
                                                
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                                return
                            }
                        }
                    }                    
                }
            } else {
                self.present(AlertFactory.defaultNoInternetAlert, animated: true, completion: nil)
            }
        }
    }
}

// MARK: - Extension for Table View
extension CurrencyListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredCurrenciesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL_IDENTIFIER) as? CurrencyTableViewCell {
            let theCurrency = self.filteredCurrenciesList[indexPath.row]
            
            cell.currencyCodeLabel.text = theCurrency.code
            cell.currencyNameLabel.text = theCurrency.name
            
            return cell
        }
        
        return UITableViewCell()
    }
}


// MARK: - Extension for Search Bar
extension CurrencyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == Constants.BLANK_STRING {
            self.filteredCurrenciesList = currenciesList
        } else {
            self.filteredCurrenciesList = filteredCurrenciesList.filter {
                $0.code.lowercased().contains(searchText.lowercased())
                    || $0.name.lowercased().contains(searchText.lowercased())
                
            }
        }
        
        self.tableView.reloadData()
    }
}
