//
//  CurrencyListView.swift
//  Desafio-BTG
//
//  Created by Euclides Medeiros on 01/04/21.
//

import UIKit

protocol DismissScreen {
    func dismissScreenTapped()
}

class CurrencyListView: UIView {
    
    // MARK: - Properties
    
    lazy var searchBar: UISearchBar = {
        let v = UISearchBar()
        v.placeholder = "search"
        v.barTintColor = .white
        v.delegate = self
        v.isTranslucent = false
        v.searchBarStyle = .minimal
        v.keyboardType = .alphabet
        v.keyboardAppearance = .dark
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    var alertAction: (() -> Void)?
    var delegate: DismissScreen?
    var viewModel: CurrencyViewModel?
    var isSearching: Bool = false
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Override & Initializers
    
    convenience init(viewModel: CurrencyViewModel?) {
        self.init()
        self.viewModel = viewModel
        setupViewHierarchy()
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CurrencyListCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tableView.backgroundColor = .clear
    }
    
    // MARK: - Private functions
    
    private func setupViewHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(tableView)
    }
    
    private func setupConstraints() {
        searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 60).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -24).isActive = true
        
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 24).isActive = true
    }
}

// MARK: - Extensions

extension CurrencyListView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  isSearching ? viewModel?.setSearchBar.count ?? 0 : viewModel?.modelValueList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyListCell
        
        
        cell.setup( isSearching ? viewModel?.setSearchBar[indexPath.row].key ?? "" : viewModel?.setContentCurrencies[indexPath.row].key ?? "", isSearching ? viewModel?.setSearchBar[indexPath.row].value ?? "" : viewModel?.setContentCurrencies[indexPath.row].value ?? "")
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let keyArray = isSearching ? viewModel?.setSearchBar[indexPath.row].key : viewModel?.setContentCurrencies[indexPath.row].key
        if SelectedCurrencySingleton.selectedCurrency == selectedCurrency.ofCurrency {
            viewModel?.gettingCountryOne(countryOne: keyArray ?? "")
        } else {
            viewModel?.gettingCountryTwo(countryTwo: keyArray ?? "")
        }
        delegate?.dismissScreenTapped()
    }
}

extension CurrencyListView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel?.filterData = viewModel?.modelValueList.filter { $0.value.prefix(searchText.count) == searchText } ?? [:]
        isSearching = true
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if viewModel?.setSearchBar.count == 0 {
            alertAction?()
        }else {
            searchBar.resignFirstResponder()
        }
    }
}
