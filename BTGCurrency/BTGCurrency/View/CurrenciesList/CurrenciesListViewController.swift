//
//  CurrenciesListViewController.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import UIKit

class CurrenciesListViewController: FloatViewController {
    @IBOutlet weak var currenciesTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var contentBottomConstraint: NSLayoutConstraint!
    
    var viewModel: CurrenciesListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableViews()
        viewModel = CurrenciesListViewModel()
        checkBehavior()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createKeyboardObserver(contentBottomConstraint: contentBottomConstraint)
    }
    
    @IBAction func confirm(_ sender: Any) {
        if viewModel!.isSelectionValid(currenciesTableView: currenciesTableView) {
            let selectedIndexPath = currenciesTableView.indexPathForSelectedRow!
            let selectedCurrency = viewModel!.getCurrency(at: selectedIndexPath.row, search: searchBar.text)
            viewModel?.setCurrency(currency: selectedCurrency)
            checkBehavior()
        }
    }
}

extension CurrenciesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfRowsInSection(search: searchBar.text) ?? 0
 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyViewCell.className, for: indexPath) as! CurrencyViewCell
        let search = searchBar.text
        let currency = viewModel!.getCurrency(at: indexPath.row, search: search)
        cell.setCurrency(currency)
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor(rgb: 0xD3C94E)
        cell.backgroundColor = UIColor(rgb: 0x545454)
        return cell
    }
}

extension CurrenciesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        currenciesTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension CurrenciesListViewController {
    func checkBehavior() {
        switch viewModel!.getCurrentBehavior() {
        case .InputLocalCurrency:
            label.text = "Converter de:"
            clearSearch()
        case .InputForeignCurrency:
            label.text = "Para:"
            clearSearch()
        case .Advance:
            viewModel?.goToExchange()
        }
    }
    func configTableViews() {
        currenciesTableView.register(UINib(nibName: CurrencyViewCell.className, bundle: nil), forCellReuseIdentifier: CurrencyViewCell.className)
    }
    func clearSearch() {
        searchBar.text = ""
        viewModel?.clearTableView(tableView: currenciesTableView)
        currenciesTableView.reloadData()
    }
}
