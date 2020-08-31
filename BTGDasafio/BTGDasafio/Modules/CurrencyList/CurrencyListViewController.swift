//
//  CurrencyListViewController.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 28/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import UIKit

class CurrencyListViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filter: UISegmentedControl!
    
    weak var activityIndicatorView: UIActivityIndicatorView!

    var viewModel = CurrencyListViewModel(hasError: false, isLoading: true)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicator()
        configureViewModel()
        viewModel.searchForCurrency()
    }
    
    private func configureSearchBar() {
        searchBar.isUserInteractionEnabled = viewModel.isSearchBarEnable
        searchBar.searchTextField.clearButtonMode = .never
    }
    
    private func configureViewModel() { viewModel.deleagte = self }

    private func updateView() {
        searchBar.isUserInteractionEnabled = viewModel.isSearchBarEnable
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView(frame: .zero)
        activityIndicatorView.stopAnimating()
        tableView.reloadData()
        if viewModel.hasError {
            showAlert(viewModel.alertTitle, viewModel.alertMessage)
        }
    }
    
    
    @IBAction func changeFilter(_ sender: Any) {
        let sort: SortBy = filter.selectedSegmentIndex == 0 ? .code : .name
        viewModel.sortList(by: sort)
    }
    
    private func configureActivityIndicator() {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        tableView.backgroundView = activityIndicatorView
        self.activityIndicatorView = activityIndicatorView
        tableView.separatorStyle = .none
        self.activityIndicatorView.startAnimating()
    }
}

extension CurrencyListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.cellTitle(at: indexPath.row)
        cell.detailTextLabel?.text = viewModel.cellMessage(at: indexPath.row)
        return cell
    }
}

extension CurrencyListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.resetSearchList()
        searchBar.resignFirstResponder()
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterList(by: searchText.lowercased())
    }
}

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    func refreshView() {
         DispatchQueue.main.async { self.updateView() }
    }
}
