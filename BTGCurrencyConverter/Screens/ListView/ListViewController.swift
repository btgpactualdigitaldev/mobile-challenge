//
//  ListViewController.swift
//  BTGCurrencyConverter
//
//  Created by Ian McDonald on 22/07/20.
//  Copyright © 2020 Ian McDonald. All rights reserved.
//

import UIKit

protocol ListViewSelectionDelegate {
    func didSelect(currency: Currency)
}

class ListViewController: UIViewController {
    enum Section { case main }
    
    let viewModel: ListViewViewModel
    var delegate: ListViewSelectionDelegate?
    var currencies: [Currency] = []
    var filteredCurrencies: [Currency] = []
    
    var tableView: UITableView!
    @available(iOS 13.0, *)
    lazy var dataSource = UITableViewDiffableDataSource<Section, Currency>()
    
    init(viewModel: ListViewViewModel = ListViewViewModel.shared) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    init(viewModel: ListViewViewModel = ListViewViewModel.shared,
         delegate: ListViewSelectionDelegate) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        title = ViewControllerTitles.listSelector.rawValue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrencies()
        configureView()
        configureTableView()
        configureSearchController()
        configureOrderButton()
        configureDataSource()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateData()
    }
        
    private func getCurrencies() {
        viewModel.getCurrencies { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let currencies):
                self.currencies = currencies
                self.initializeData()
            case .failure(let error):
                let alert = UIAlertController(title: AlertController.errorTitle.rawValue,
                                              message: error.rawValue, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: AlertController.okButton.rawValue,
                                              style: .default))
                self.present(alert, animated: true)
            }
        }
    }
    
    private func configureView() {
        view.backgroundColor = UIColor(named: .background)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: .background)
        tableView.register(BTGListViewCell.self, forCellReuseIdentifier: BTGListViewCell.reuseID)
        tableView.delegate = self
        tableView.removeExcessCells()
    }
        
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = PlaceholderText.searchBar.rawValue
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
        
    private func configureOrderButton() {
        let orderButton =  UIBarButtonItem(barButtonSystemItem: .action, target: self,
                                           action: #selector(orderButtonPressed))
        navigationItem.rightBarButtonItem = orderButton
    }
        
    private func configureDataSource() {
        if #available(iOS 13.0, *) {
            dataSource = UITableViewDiffableDataSource<Section, Currency>(
                tableView: tableView,
                cellProvider: { tableView, indexPath, currency -> UITableViewCell? in
                    guard let cell = tableView.dequeueReusableCell(
                        withIdentifier: BTGListViewCell.reuseID, for: indexPath) as? BTGListViewCell
                        else {
                            fatalError(BTGTableViewError.errorBTGListViewCell.rawValue)
                    }
                    cell.set(currency: currency)
                    
                    return cell
            })
        } else {
            tableView.dataSource = self
        }
    }

    private func initializeData() {
        filteredCurrencies = currencies
        updateData()
    }
    
    private func updateData() {
        if #available(iOS 13.0, *) {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Currency>()
            snapshot.appendSections([.main])
            snapshot.appendItems(filteredCurrencies)
            
            DispatchQueue.main.async {
                self.dataSource.apply(snapshot, animatingDifferences: true)
            }
        } else {
            DispatchQueue.main.async {
                // This is not efficient, in a production app a diffing algorithm should be used
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func orderButtonPressed() {
        let alertVC = UIAlertController(title: AlertController.orderTitle.rawValue, message: nil,
                                        preferredStyle: .actionSheet)
        alertVC.addAction(UIAlertAction(title: AlertController.byName.rawValue, style: .default,
                                        handler: { _ in
            self.filteredCurrencies.sort { $0.name.lowercased() < $1.name.lowercased() }
            self.currencies.sort { $0.name.lowercased() < $1.name.lowercased()}
            self.updateData()
        }))
        alertVC.addAction(UIAlertAction(title: AlertController.bySymbol.rawValue, style: .default,
                                        handler: { _ in
            self.filteredCurrencies.sort { $0.symbol.lowercased() < $1.symbol.lowercased() }
            self.currencies.sort { $0.symbol.lowercased() < $1.symbol.lowercased()}
            self.updateData()
        }))
        alertVC.addAction(UIAlertAction(title: AlertController.cancelButton.rawValue,
                                        style: .cancel))
        
        present(alertVC, animated: true)
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelect(currency: filteredCurrencies[indexPath.row])
            dismiss(animated: true)
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCurrencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BTGListViewCell.reuseID,
                                                       for: indexPath) as? BTGListViewCell else {
            fatalError(BTGTableViewError.errorBTGListViewCell.rawValue)
        }
        cell.set(currency: filteredCurrencies[indexPath.row])
        
        return cell
    }
}

extension ListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            filteredCurrencies = currencies
            updateData()
            return
        }
        
        filteredCurrencies = currencies.filter { $0.name.lowercased().contains(filter.lowercased())
            || $0.symbol.lowercased().contains(filter.lowercased())
        }
        updateData()
    }
}
