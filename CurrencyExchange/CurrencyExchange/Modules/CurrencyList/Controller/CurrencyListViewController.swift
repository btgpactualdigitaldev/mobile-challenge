//
//  CurrencyListViewController.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

protocol CurrencyListViewControllerDelegate: class {
    func backToExchangeViewControllerWithCurrency(_ currency: Currency, withCurrencyButtonType type: CurrencyButtonType)
    func dismissAndBackToExchangeViewController()
}

class CurrencyListViewController: UIViewController {
    
    // MARK: - Properties
    
    weak var coordinator: CurrencyListViewControllerDelegate?
    
    var viewModel: CurrencyListViewModel
    
    private var currencyListTableViewDataSource: CurrencyListTableViewDataSource? {
        didSet {
            guard let dataSource = currencyListTableViewDataSource else { return }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.currencyListView.tableView.dataSource = dataSource
                self.currencyListView.tableView.reloadData()
            }
        }
    }
    
    private var currencyListTableViewDelegate: CurrencyListTableViewDelegate? {
        didSet {
            guard let delegate = currencyListTableViewDelegate else { return }
            
            delegate.didSelectCurrency = { [weak self] currency in
                guard let self = self else { return }
                self.didSelectOnCurrency(currency)
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.currencyListView.tableView.delegate = delegate
            }
        }
    }
    
    private var currencySearchBarDelegate: CurrencySearchBarDelegate? {
        didSet {
            guard let delegate = currencySearchBarDelegate else { return }
            
            delegate.reloadToApplyFilter = { [weak self]  in
                self?.setupTableViewDataSourceAndDelegate()
            }
            
            delegate.didFilteredCurrencies = { [weak self] currencies in
                guard let self = self else { return }
                self.currencyListTableViewDelegate = CurrencyListTableViewDelegate(currencies: currencies)
                self.currencyListTableViewDataSource = CurrencyListTableViewDataSource(currencies: currencies)
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.searchBarController.searchBar.delegate = delegate
            }
        }
    }
    
    private lazy var searchBarController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.searchTextField.textColor = .black
        searchController.searchBar.scopeButtonTitles = [CurrencyFilterSearchBar.nome.rawValue, CurrencyFilterSearchBar.codigo.rawValue]
        return searchController
    }()
    
    private var currencyListView: CurrencyListView = {
        let view = CurrencyListView(frame: .zero)
        return view
    }()
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.delegate = self
        self.viewModel.loadData()
        self.currencyListView.tableView.tableHeaderView = searchBarController.searchBar
        self.currencyListView.cancelBarButton.action = #selector(tappedOnCancelButton)
        self.currencyListView.cancelBarButton.target = self
        self.hideKeyboardWhenTappedAround()
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        self.view = currencyListView
    }
    
    
    // MARK: - Methods
    
    private func didSelectOnCurrency(_ currency: Currency){
        self.coordinator?.backToExchangeViewControllerWithCurrency(currency, withCurrencyButtonType: viewModel.currencyButtonType)
    }
    
    
    private func setupTableViewDataSourceAndDelegate(){
        self.currencyListTableViewDelegate = CurrencyListTableViewDelegate(currencies: viewModel.currencies)
        self.currencyListTableViewDataSource = CurrencyListTableViewDataSource(currencies: viewModel.currencies)
        self.currencySearchBarDelegate = CurrencySearchBarDelegate(viewModel: viewModel)
    }
    
    // MARK: - Selectors
    
    @objc func tappedOnCancelButton(){
        self.coordinator?.dismissAndBackToExchangeViewController()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CurrencyListViewController: CurrencyListViewModelDelegate {
    func willLoadData() {
        self.currencyListView.showLoadingIndicator(view: currencyListView)
    }
    
    func didLoadData(message: String?) {
        if let message = message {
            print(message)
        }else {
            setupTableViewDataSourceAndDelegate()
        }
        
        DispatchQueue.main.async {
            self.currencyListView.dismissLoadingIndicator()
        }
    }
    
    
}
