//
//  CurrencySelectionViewController.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 08/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import UIKit

class CurrencySelectionViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    enum CurrencyType {
        case first
        case second
    }
    
    var currencyType: CurrencyType = .first
    var viewModel: CurrencyViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    private func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        self.searchBar.delegate = self
        tableView.register(UINib(nibName: "CurrencySelectionTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencySelectionTableViewCell")
    }
}

extension CurrencySelectionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfCurrencies() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencySelectionTableViewCell", for: indexPath) as! CurrencySelectionTableViewCell
        cell.setup(self.viewModel?.currencyFor(row: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) {
            if let cell = tableView.cellForRow(at: indexPath) as? CurrencySelectionTableViewCell, let currency = cell.currency {
                (self.currencyType == .first) ? self.viewModel?.selectFirst(currency: currency) : self.viewModel?.selectSecond(currency: currency)
            }
        }
    }
}

extension CurrencySelectionViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.viewModel?.searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.viewModel?.searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel?.searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel?.filterCurrencyby(text: searchText)
        self.tableView.reloadData()
    }
}
