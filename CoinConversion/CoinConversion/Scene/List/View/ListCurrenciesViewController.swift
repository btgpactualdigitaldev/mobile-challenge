//
//  ListCurrenciesViewController.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 19/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import UIKit

// MARK: - Main
class ListCurrenciesViewController: UITableViewController {
    
    var viewModel: ListCurrenciesViewModel?
    private let searchController = UISearchController(searchResultsController: nil)
    
    init(viewModel: ListCurrenciesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ListCurrenciesViewController.nibName, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - UITableViewController lifecycle
extension ListCurrenciesViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = .colorBackground
        
        setupNavigationBar()
        setupBarButton()
        registerTableView()
        
        viewModel?.delegate = self
        viewModel?.fetchListCurrencies(isRefresh: false)
    }
}

// MARK: - Private methods
extension ListCurrenciesViewController {
    private func setupNavigationBar() {
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: .colorDarkishPink,
                               tintColor: .white,
                               title: "Lista de moedas",
                               preferredLargeTitle: true,
                               isSearch: true,
                               searchController: setupSearchController()
        )
    }
    
    private func setupBarButton() {
        let button = UIBarButtonItem(
            barButtonSystemItem: .refresh,
            target: self,
            action: #selector(refreshButtonTouched(sender:))
        )
        button.tintColor = .white
        navigationItem.rightBarButtonItem = button
    }
    
    @objc private func refreshButtonTouched(sender: UIBarButtonItem) {
        viewModel?.fetchListCurrencies(isRefresh: true)
    }
    
    private func doLoading(action: UIAlertAction) {
        viewModel?.fetchListCurrencies(isRefresh: true)
    }
    
    private func setupSearchController() -> UISearchController {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        let searchBar = searchController.searchBar
        searchBar.tintColor = .white
        searchBar.barTintColor = .white
        searchBar.searchTextField.backgroundColor = .white
        searchBar.searchTextField.textColor = .colorGrayPrimary
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.clipsToBounds = true
        
        return searchController
    }
    
    private func registerTableView() {
        tableView.register(
            UINib(nibName: ListCurrenciesSectionViewCell.identifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: ListCurrenciesSectionViewCell.identifier
        )
        tableView.register(
            UINib(nibName: ListCurrenciesViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: ListCurrenciesViewCell.identifier
        )
        tableView.register(
            UINib(nibName: EmptySearchViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: EmptySearchViewCell.identifier
        )
    }
}

// MARK: - UISearchResultsUpdating
extension ListCurrenciesViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            viewModel?.searchListCurrencies(whit: text)
        }
        
        if let text = searchController.searchBar.text, text.isEmpty {
            viewModel?.searchListCurrencies(whit: "")
        }
    }
}

// MARK: - UITableViewDataSource
extension ListCurrenciesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listCurrencies = viewModel?.listCurrencies else {
            return 0
        }
        if listCurrencies.count == 0 { return 1 }
        return listCurrencies.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: ListCurrenciesSectionViewCell.identifier) as? ListCurrenciesSectionViewCell else {
            fatalError("Couldn't dequeue \(ListCurrenciesSectionViewCell.identifier)")
        }
        
        if !(viewModel?.isSort ?? false) {
            cell.setupRadioButtons(tag: 0, buttons: cell.sortByNameButton)
        }
        
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCurrencies = viewModel?.listCurrencies else {
            return UITableViewCell()
        }
        
        if listCurrencies.count == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: EmptySearchViewCell.identifier, for: indexPath)
                as? EmptySearchViewCell else {
                    
                    fatalError("Couldn't dequeue \(ListCurrenciesViewCell.identifier)")
            }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCurrenciesViewCell.identifier, for: indexPath)
            as? ListCurrenciesViewCell else {
                
                fatalError("Couldn't dequeue \(ListCurrenciesViewCell.identifier)")
        }
        
        let currencies = listCurrencies[indexPath.row]
        cell.bind(
            name: currencies.name,
            currency: currencies.code
        )
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let listCurrencies = viewModel?.listCurrencies else {
            fatalError("listCurrencies can't be nil")
        }
        
        tableView.keyboardDismissMode = .onDrag
        searchController.searchBar.endEditing(true)
        searchController.dismiss(animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            let currencies = listCurrencies[indexPath.row]
            self.viewModel?.chosenCurrencies(code: currencies.code, name: currencies.name)
        }
    }
}

// MARK: - UITableViewDelegate
extension ListCurrenciesViewController {
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 82
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel?.listCurrencies?.count == 0 {
            return 230
        }
        return 100
    }
}

// MARK: - ListCurrenciesSectionViewCellDelegate
extension ListCurrenciesViewController: ListCurrenciesSectionViewCellDelegate {
    func didTapSortBy(_ sortType: SortType) {
        
        guard let listCurrencies = viewModel?.listCurrencies else {
            fatalError("listCurrencies cannot be null")
        }
        
        viewModel?.fetchLisSortBy(sortType, with: listCurrencies)
    }
}

// MARK: - ListCurrenciesViewModelDelegate
extension ListCurrenciesViewController: ListCurrenciesViewModelDelegate {
    func didStartLoading() {
        showActivityIndicator()
    }
    
    func didHideLoading() {
        hideActivityIndicator()
    }
    
    func didReloadData() {
        UIView.transition(with: self.tableView, duration: 0.35, options: .transitionCrossDissolve, animations: {
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: IndexPath(row: NSNotFound, section: 0), at: .top, animated: true)
        })
    }
    
    func didFail(with title: String, message: String, buttonTitle: String, noConnection: Bool, dataSave: Bool) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        if noConnection && !dataSave {
            alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: doLoading))
        } else {
            alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))
        }
        present(alert, animated: true, completion: nil)
    }
}
