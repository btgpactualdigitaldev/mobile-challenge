//
//  CurrencyListViewController.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 22/03/21.
//

import UIKit

final class CurrencyListViewController: UITableViewController {
    
    var viewModel: CurrencyListViewModel
    var searchBar: UISearchBar
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        self.searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
        super.init(style: .plain)
        tableView.separatorColor = DesignSystem.Color.primary
        tableView.backgroundColor = DesignSystem.Color.darkPrimary
        self.tableView.tableHeaderView = searchBar
        searchBar.backgroundColor = DesignSystem.Color.darkPrimary
        searchBar.barTintColor = DesignSystem.Color.darkPrimary
        searchBar.tintColor = DesignSystem.Color.secondary
        searchBar.searchTextField.backgroundColor = DesignSystem.Color.primary
        searchBar.searchTextField.textColor = DesignSystem.Color.white
        if let searchIcon = searchBar.searchTextField.leftView as? UIImageView {
            searchIcon.tintColor = DesignSystem.Color.secondary
        }
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reusableIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.updateCurrencies()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CurrencyTableViewCell.reusableIdentifier
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? CurrencyTableViewCell else {
            preconditionFailure("No reusable cell registered with identifier: \(identifier)")
        }
        
        let currency = viewModel.filteredCurrencies[indexPath.row]
        
        cell.textLabel?.text = currency.name
        cell.detailTextLabel?.text = currency.code
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rowsInSection
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectCurrency(currency: viewModel.filteredCurrencies[indexPath.row])
    }
    
    func update() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension CurrencyListViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterCurrencies(search: searchText)
    }
}
