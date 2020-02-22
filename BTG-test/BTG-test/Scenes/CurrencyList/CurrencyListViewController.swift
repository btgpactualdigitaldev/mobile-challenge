//
//  CurrencyListViewController.swift
//  BTG-test
//
//  Created by Matheus Ribeiro on 20/02/20.
//  Copyright © 2020 Matheus Ribeiro. All rights reserved.
//

import UIKit

protocol CurrencyListViewControllerDelegate: class {
    func didSelectCurrency(currencyListViewController: CurrencyListViewController, currency: Currency)
}

class CurrencyListViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    
    weak var delegate: CurrencyListViewControllerDelegate?
    var viewModel: CurrencyListViewModel?
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        configureSearchBar()
    }
    
    private func configureSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar moeda"
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = self.searchController
    }
    
    private func setupTableView() {
        func registerTableViewCells() {
            let nib = UINib(nibName: "CurrencyListTableViewCell", bundle: nil)
            let reuseIdentifier = CurrencyListTableViewCell.reuseIdentifier
            tableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        }
        
        registerTableViewCells()
    }
}

extension CurrencyListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        viewModel?.filter(text: text)
        tableView.reloadData()
    }
}

extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let isFiltering = viewModel?.isFiltering else { return 0 }
        if isFiltering {
            return viewModel?.filtered.count ?? 0
        } else {
            return viewModel?.currencies.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CurrencyListTableViewCell.reuseIdentifier
        guard
            let viewModel = viewModel,
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CurrencyListTableViewCell
            else { return .init() }
        let index = indexPath.row
        let currency = viewModel.isFiltering ? viewModel.filtered[index] : viewModel.currencies[index]
        let currencyTitle = currency.title
        let currencyDescription = currency.description
        let cellViewModel = CurrencyListTableViewCell.ViewModel(currencyTitle: currencyTitle, currencyDescription: currencyDescription)
        cell.viewModel = cellViewModel
        return cell
    }
}

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        guard let viewModel = viewModel else { return }
        let currency = viewModel.isFiltering ? viewModel.filtered[index] : viewModel.currencies[index]
        delegate?.didSelectCurrency(currencyListViewController: self, currency: currency)
    }
}
