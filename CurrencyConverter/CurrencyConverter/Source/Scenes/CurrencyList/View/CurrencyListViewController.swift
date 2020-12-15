//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Italo Boss on 13/12/20.
//

import UIKit

class CurrencyListViewController: UIViewController {
    
    lazy var contentView = CurrencyListView()
        .run {
            $0.currenciesTableView.dataSource = self
            $0.currenciesTableView.delegate = self
            $0.searchBar.delegate = self
            $0.cancelButton.addTarget(self, action: #selector(didTapCancelButton), for: .touchUpInside)
        }
    
    var viewModel: CurrencyListViewModeling
    
    // MARK: - Initializers
    
    init(viewModel: CurrencyListViewModeling = CurrencyListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = CurrencyListViewModel()
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        view = contentView
        viewModel.delegate = self
    }
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadCurrencyList()
    }
    
    // MARK: - Actions
    
    @objc func didTapCancelButton() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CurrencyListViewController: CurrencyListViewModelDelegate {
    
    func updateUI() {
        contentView.currenciesTableView.reloadData()
    }
    
    func presentError(with message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func shouldShowLoading(_ isLoading: Bool) {
        DispatchQueue.main.async {
            self.contentView.isLoading = isLoading
        }
    }
    
    func close() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource

extension CurrencyListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currienciesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(CurrencyTableViewCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        
        let currency = viewModel.getCurrencyAt(index: indexPath.row)
        cell.textLabel?.text = currency.name
        cell.detailTextLabel?.text = currency.code
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate

extension CurrencyListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCurrencyAt(index: indexPath.row)
    }
    
}

// MARK: - UISearchBarDelegate

extension CurrencyListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchCurrenciesFor(text: searchText)
    }
    
}
