//
//  CurrenciesViewController.swift
//  CurrencyBuddy
//
//  Created by Rodrigo Giglio on 21/12/20.
//

import UIKit
import NotificationCenter

enum ConvertionType {
    case input
    case output
}

class CurrenciesViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Attributtes
    let service = Service<CurrencyEndpoints>()
    var allCurrencies: [Currency] = []
    var filteredCurrencies: [Currency] = []
    var convertionType: ConvertionType?
    weak var convertionViewControllerDelegate: ConvertViewControllerDelegate?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.searchTextField.delegate = self
        searchBar.searchTextField.returnKeyType = .done

        
        let service = Service<CurrencyEndpoints>()

        startIndicatingActivity()
        service.request(.list) {
            (result: Result<CurrencyResponse,Error>) in

            switch result {

            case .failure(let error):
                print(error.localizedDescription)
                self.showErrorAlert()

            case .success(let currencyResponse):
                self.allCurrencies = Currency.fromDictionary(currencyResponse.currencies)
                self.filteredCurrencies = self.allCurrencies
                self.tableView.reloadData()
            }
            
            self.stopIndicatingActivity()
        }
    }
}

// MARK: - UITableViewDataSource
extension CurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currency = filteredCurrencies[indexPath.row]
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = currency.code
        cell.detailTextLabel?.text = currency.name
        cell.selectionStyle = .none

        return cell
    }
}

// MARK: - UITableViewDelegate
extension CurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let convertionType = convertionType else { return }
        
        let currency = filteredCurrencies[indexPath.row]
        convertionViewControllerDelegate?.didChangeCurrency(currency, for: convertionType)
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UISearchBarDelegate
extension CurrenciesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText.isEmpty {
            undoFilter()
            return
        }
        
        filteredCurrencies = allCurrencies.filter({ (currency) -> Bool in
            return currency.code.uppercased().contains(searchText.uppercased()) ||
                currency.name.uppercased().contains(searchText.uppercased())
        })
        
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func undoFilter() {
        filteredCurrencies = allCurrencies
        tableView.reloadData()
    }
}

// MARK: - UITextFieldDelegate
extension CurrenciesViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
