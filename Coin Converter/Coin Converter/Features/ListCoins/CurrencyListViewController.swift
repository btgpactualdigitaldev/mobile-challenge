//
//  CurrencyListViewController.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 28/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    //*************************************************
    // MARK: - Outlets
    //*************************************************
    
    @IBOutlet private weak var currenciesTableView: UITableView!
    
    //*************************************************
    // MARK: - Public Properties
    //*************************************************
    
    weak var delegate: CoinConversionViewControllerDelegate?
    
    //*************************************************
    // MARK: - Private Properties
    //*************************************************
    
    private weak var searchController: UISearchController?
    
    private let titleNavigationBar: String = "Select Currency"
    private let viewModel: CurrencyListViewModel
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //*************************************************
    // MARK: - Lifecycle
    //*************************************************

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension CurrencyListViewController {
    
    private func setupView() {
        title = titleNavigationBar
        setupTableView()
        setupSearchBar()
    }
    
    private func setupTableView() {
        currenciesTableView.register(CurrencyCell.nib, forCellReuseIdentifier: CurrencyCell.identifier)
        
        currenciesTableView.delegate = self
        currenciesTableView.dataSource = self
        currenciesTableView.rowHeight = UITableView.automaticDimension
        currenciesTableView.estimatedRowHeight = 80
    }
    
    private func setupSearchBar() {
        let searchController: UISearchController = UISearchController(searchResultsController: nil)
        //searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Currency"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        self.searchController = searchController
    }
}

//*************************************************
// MARK: - UITableViewDataSource
//*************************************************

extension CurrencyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.identifier, for: indexPath) as? CurrencyCell else {
            return UITableViewCell()
        }
        let currencyCellViewModel: CurrencyCellViewModel = viewModel.currencyCellViewModel(row: indexPath.row)
        cell.setup(viewModel: currencyCellViewModel)
        return cell
    }
    
}

//*************************************************
// MARK: - UITableViewDelegate
//*************************************************

extension CurrencyListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.updateSelectedCurrency(currencyModel: viewModel.showCurrencies[indexPath.row])
        navigationController?.popToRootViewController(animated: true)
    }
}

//*************************************************
// MARK: - UISearchControllerDelegate
//*************************************************

extension CurrencyListViewController: UISearchControllerDelegate {
    
}

//*************************************************
// MARK: - UISearchResultsUpdating
//*************************************************

extension CurrencyListViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    viewModel.filter(searchText: searchController.searchBar.text) { [weak self] in
        DispatchQueue.main.async {
            self?.currenciesTableView.reloadData()
        }
    }
  }
}
