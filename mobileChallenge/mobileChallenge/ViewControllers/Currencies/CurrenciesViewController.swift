//
//  CurrenciesViewController.swift
//  mobileChallenge
//
//  Created by Renato Carvalhan on 03/12/20.
//  Copyright © 2020 Renato Carvalhan. All rights reserved.
//

import UIKit

//protocol CurrenciesViewControllerDelegate: class {
//    func selectCurrency(currency: Currency)
//}

class CurrenciesViewController: UIViewController {
    
//    weak var delegate: CurrenciesViewControllerDelegate?
    private let viewModel: CurrenciesViewModel
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Currencies"
        searchController.searchBar.delegate = self
        
        return searchController
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.registerReusableCell(CurrencyCell.self)

        return tableView
    }()
    
    init(viewModel: CurrenciesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func selected(indexPath: IndexPath) {
       let currency = viewModel.findCurrencyBy(indexPath: indexPath)
       selectCurrency(currency: currency)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
    }
    
    private func setupNavBar() {
        title = viewModel.type.title
        definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(back))
    }
    
    private func setupView() {
        self.view.addSubview(self.tableView)
        
        buildConstraints()
    }
    
    private func buildConstraints() {
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func selectCurrency(currency: Currency) {
        viewModel.update(currency: currency)
    }
}

//MARK: - UITableViewDelegate and UITableViewDataSource
extension CurrenciesViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(indexPath: indexPath) as CurrencyCell
        let currency = viewModel.filterCurrencies[indexPath.row]
        cell.setupCell(currency: currency)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = viewModel.filterCurrencies[indexPath.row]
        selectCurrency(currency: currency)
    }
}

// MARK: - UISearchBarDelegate
extension CurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String) {
        viewModel.filterBy(text: textSearched)
        tableView.reloadData()
    }
}

extension CurrenciesViewController {
    
    @objc func back() {
        viewModel.back()
    }
}
