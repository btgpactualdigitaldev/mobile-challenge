//
//  CurrencyListViewController.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import UIKit

final class CurrencyListViewController: UIViewController {
    
    private lazy var pickerTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.delegate = tableViewDelegate
        tableView.dataSource = tableViewDataSource
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var tableViewDelegate: CurrencyListTableViewDelegate = CurrencyListTableViewDelegate { [weak self] (cell) in 
        self?.viewModel.swapCurrencies(newCode: cell.currencyID, newName: cell.currencyName)
    }
    
    private lazy var tableViewDataSource: CurrencyListTableViewDataSource = CurrencyListTableViewDataSource(viewModel: viewModel)

    private let viewModel: CurrencyListViewModel
    
    weak var searchBarDelegate: SearchBarDelegate?
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "Search for Currencies"
        navigationItem.searchController = searchController
        definesPresentationContext = true

        return searchController
    }()
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    private lazy var sortBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "slider.vertical.3"), style: .plain, target: self, action: #selector(sortTableView))
        return button
    }()
    
    private var sortingState: SortingType = .name
        
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        guard let viewModel = coder.decodeObject(forKey: "viewModel") as? CurrencyListViewModel else {
            return nil
        }
        self.init(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.rightBarButtonItem = sortBarButton
        setupTableViewConstraints()
        navigationItem.searchController = searchController
    }
    
    private func setupTableViewConstraints() {
        self.view.addSubview(pickerTableView)
        pickerTableView.addAnchor(top: self.view.safeAreaLayoutGuide.topAnchor, leading: self.view.safeAreaLayoutGuide.leadingAnchor, trailing: self.view.safeAreaLayoutGuide.trailingAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, widht: nil, height: nil)
    }
    
    @objc func sortTableView() {
        switch sortingState {
        case .name:
            sortingState = .code
        case .code:
            sortingState = .name
        }
        viewModel.sortResponse(by: sortingState, tableView: pickerTableView)
    }
}

extension CurrencyListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let value = searchController.isActive && !isSearchBarEmpty
        searchBarDelegate?.isFiltering(value)
        viewModel.filterContentForSearchText(searchBar.text ?? "", tableView: pickerTableView)
    }
}

