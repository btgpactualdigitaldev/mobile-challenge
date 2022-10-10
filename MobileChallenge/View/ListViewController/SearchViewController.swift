//
//  SearchViewController.swift
//  MobileChallenge
//
//  Created by Thiago de Paula Lourin on 14/10/20.
//

import UIKit

protocol SearchViewDelegate: class {
    func didSelectFrom(selected: String)
    func didSelectTo(selected: String)
}

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ListViewModel!
    private var searchController: UISearchController!
    private weak var delegate: SearchViewDelegate?
    private var isSource: Bool
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    init(delegate: SearchViewDelegate, isSource: Bool) {
        self.delegate = delegate
        self.isSource = isSource
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ListViewModel()
        setupSearchController()
        
        setupTableView()
    }
    
    func filterContent(_ searchText: String) {
        viewModel.filteredCurrencyList = viewModel.currencyList.filter({ (currency: CurrencyType) -> Bool in
            return currency.rawValue.lowercased().contains(searchText.lowercased()) || String(describing: currency).lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Currency"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: String(describing: ListTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ListTableViewCell.self))
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel.getFilteredCount()
        }
        return viewModel.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ListTableViewCell.self), for: indexPath) as? ListTableViewCell else { return ListTableViewCell() }
                
        cell.initView(code: viewModel.getCurrencyCode(index: indexPath.row, isFiltering), name: viewModel.getCurrencyRawValue(index: indexPath.row, isFiltering))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = viewModel.getCurrencyCode(index: indexPath.row, isFiltering)
        
        if isSource {
            delegate?.didSelectFrom(selected: selected)
        } else {
            delegate?.didSelectTo(selected: selected)            
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.popViewController(animated: true)
    }
}

extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContent(searchBar.text!)
    }
}
