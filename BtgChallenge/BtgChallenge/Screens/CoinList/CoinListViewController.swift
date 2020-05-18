//
//  CoinListViewController.swift
//  BtgChallenge
//
//  Created by Felipe Alexander Silva Melo on 13/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import UIKit

protocol CoinListCoordinatorDelegate: class {
    func close()
}

protocol CoinListViewControllerDelegate: class {
    func updateCoin(viewModel: CoinListCellViewModel)
}

class CoinListViewController: UIViewController {

    // MARK: - Constants
    
    static let searchBarPlaceholder = "Search..."
    
    // MARK: - Properties
    
    var coinListView: CoinListView?
    var viewModel: CoinListViewModelInput?
    var coordinator: CoinListCoordinatorDelegate?
    
    weak var delegate: CoinListViewControllerDelegate?
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = CoinListViewController.searchBarPlaceholder
        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = .darkBlue
        searchController.searchBar.searchTextField.backgroundColor = .white
        
        return searchController
    }()
    
    init(viewModel: CoinListViewModelInput,
         coordinator: CoinListCoordinatorDelegate,
         delegate: CoinListViewControllerDelegate?
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func loadView() {
        super.loadView()
        coinListView = CoinListView(viewController: self)
        view = coinListView
        title = "Select Coin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        
        viewModel?.viewDidLoad()
    }

}

extension CoinListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel?.searchForCoin(string: searchController.searchBar.text ?? "")
    }
}

extension CoinListViewController: CoinListViewModelOutput {
    func displayCoinList(viewModel: CoinListTableViewModel) {
        coinListView?.coinListTableView.update(viewModel: viewModel)
    }
    
    func displayListError(message: String) {
        presentAlert(message: message) { [weak self] in
            self?.coordinator?.close()
        }
    }
}

extension CoinListViewController: CoinListTableViewDelegate {
    func didSelectRow(viewModelSelected: CoinListCellViewModel) {
        coordinator?.close()
        delegate?.updateCoin(viewModel: viewModelSelected)
    }
}
