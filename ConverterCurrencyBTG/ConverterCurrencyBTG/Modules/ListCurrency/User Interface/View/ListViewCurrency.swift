//
//  ListViewCurrency.swift
//  ConverterCurrencyBTG
//
//  Created by Thiago Vaz on 05/07/20.
//  Copyright © 2020 Thiago Santos. All rights reserved.
//

import UIKit

class ListViewCurrency: UITableViewController {
    var presenter: ListCurrencyPresenterInput!
    let cellId = "CellID"
    let searchController = UISearchController(searchResultsController: nil)
    var viewModels: [ListViewModel] = [ListViewModel]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout(){
        title = "Lista de moedas"
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Fechar", style: .plain, target: self, action: #selector(didTap))
        
        // 1
        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Pesquisar moeda"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
    }
    
    @objc func didTap(){
        presenter.didTap()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModels.count == .zero {
            tableView.setEmptyView(title: presenter.title, message: presenter.message, isLoading: presenter.isLoading)
        }else{
            tableView.restore()
        }
        return viewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle , reuseIdentifier: cellId)
        let viewModel = viewModels[indexPath.row]
        cell.textLabel?.text = viewModel.currency
        cell.detailTextLabel?.text = viewModel.name
        cell.imageView?.image = viewModel.imageView
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchController.isActive = false
        presenter.didSelected(viewModel: viewModels[indexPath.row])
    }
}

extension ListViewCurrency: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter.searchText = searchController.searchBar.text ?? ""
        presenter.searchIsActive = searchController.isActive
        presenter.updateSearch()
    }
    
}

extension ListViewCurrency: ListCurrencyPresenterOuput {
    
    func loadView(viewModels: [ListViewModel]) {
        self.viewModels = viewModels
    }
}
