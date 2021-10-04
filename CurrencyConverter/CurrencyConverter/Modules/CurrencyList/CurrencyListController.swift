//
//  CurrencyListController.swift
//  CurrencyConverter
//
//  Created by Eduardo Lopes on 29/09/21.
//

import UIKit

protocol CurrencyListDelegate {
    func didSelectCurrency(_ currency: String, origin: Origin, currencyCode: String)
}

final class CurrencyListController: UIViewController {
    
    private lazy var viewModel = CurrencyListViewModel(delegate: self)
    private lazy var customView = CurrencyListView(delegate: self, dataSource: self)
    private var delegate: CurrencyListDelegate?
    private let searchController = UISearchController(searchResultsController: nil)
    private var origin: Origin
    private var filter: String? = nil

    
    // MARK: - Initializers
    init(origin: Origin, delegate: CurrencyListDelegate) {
        self.origin = origin
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.setStatusBarStyle(UIStatusBarStyle.lightContent, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Select Currency"
    }
    
    
    
}

// MARK: - Extensions
extension CurrencyListController {
    private func setNavigationBar() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
}

extension CurrencyListController: CurrencyListViewModelDelegate {
    func failedToGetCurrencyList() {
        customView.tableView.setEmptyMessage("No currencies found")
    }
    
    func didReloadData() {
        customView.tableView.reloadData()
    }
    
}

extension CurrencyListController: UISearchBarDelegate {
    private func setSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        customView.tableView.tableHeaderView = searchController.searchBar
    }
    
}

extension CurrencyListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.updateSearchResults(for: searchController)
    }
    
}


// MARK: - TableView Extensions
extension CurrencyListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = viewModel.filteredData?[indexPath.row] else { return }
        let currencyCode = String(currency.prefix(3))
            delegate?.didSelectCurrency(currency, origin: origin, currencyCode: currencyCode)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
    }
    
}

extension CurrencyListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = viewModel.getNumberOfRows()
        if count == 0 {
            tableView.setLoad()
        } else {
            tableView.restore()
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: CurrencyCell.self)) as? CurrencyCell, let info = viewModel.filteredData else {
            return UITableViewCell()
        }
        cell.setupInfos(info[indexPath.row])
        return cell
    }
    
}
