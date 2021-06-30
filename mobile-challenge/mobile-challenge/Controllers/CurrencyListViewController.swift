//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by gabriel on 01/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    // MARK: View Model
    private let viewModel: CurrencyListViewModel
    
    // MARK: UI Elements
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.separatorColor = .systemGray6
        tableView.separatorInset = .zero
        return tableView
    }()
    
    private let tableViewDelegate: CurrencyListTableViewDelegate = CurrencyListTableViewDelegate()
    private let tableViewDataSource: CurrencyListTableViewDataSource = CurrencyListTableViewDataSource()
    
    private let searchController: UISearchController = UISearchController()
    
    // MARK: Init
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // Not used because of view code
        fatalError("init(coder:) is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegates()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: Setup methods
    private func setupDelegates() {
        viewModel.delegate = self
        searchController.searchBar.delegate = self
    }
    
    private func setupUI() {
        self.title = "Selecione uma moeda"
        navigationController?.navigationBar.backgroundColor = .systemGray6
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setupTableView()
        setupTableViewConstraints()
    }
    
    private func setupTableView() {
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        
        // Set table view delegate bindings
        tableViewDelegate.didSelectedRowAt = { [weak self] row in
            self?.viewModel.currencySelected(at: row)
        }
        
        // Set table view data source bindings
        tableViewDataSource.currencyForRow = { [weak self] row in
            return self?.viewModel.getCurrency(for: row) ?? nil
        }
        tableViewDataSource.numberOfRows = { [weak self] section in
            return self?.viewModel.numberOfRows ?? 0
        }
        
        view.addSubview(tableView)
    }
    
    private func setupTableViewConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

// MARK: View Model Delegate
extension CurrencyListViewController: CurrencyListViewModelDelegate {
    
    func dataChanged() {
        tableView.reloadData()
    }
}

// MARK: UISearchBarDelegate
extension CurrencyListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchText = searchText.lowercased()
        viewModel.filter(by: searchText)
    }
}
