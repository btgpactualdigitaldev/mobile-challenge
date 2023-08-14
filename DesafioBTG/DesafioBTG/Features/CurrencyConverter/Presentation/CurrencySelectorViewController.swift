//
//  CurrencySelectorViewController.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 03/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import UIKit
import RxSwift

class CurrencySelectorViewController: UIViewController {
    // MARK: UI Components
    let tableView = UITableView()
    lazy var searchBar: UISearchBar = UISearchBar()
    
    // MARK: Variables
    public var viewModel: CurrencySelectorViewModel!
    let disposeUIBag = DisposeBag()
    private var firstAppearing = true
    public var isSelectingFirstCurrency = true
    
    private var currencies: [Currency] = []
    private var isSearching = false
    private var filteredCurrencies: [Currency] = []
    public var currenciesToIgnore: [Currency] = []
    
    // MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if firstAppearing {
            self.setupUI()
            self.firstAppearing = false
        }
        
        self.showObstructiveLoading()
        self.viewModel.rx_updateCurrenciesList().subscribe(onNext: {[weak self] _ in
            guard let self = self else {return}
            self.hideObstructiveLoading()
            self.currencies = self.viewModel.getCurrencies()
            self.filterAlreadySelectedCurrencies()
            self.ordenateByCode()
            self.tableView.reloadData()
        }, onError: { error in
            //TO-DO: TRATAR ERRO
            self.hideObstructiveLoading()
        }).disposed(by: self.disposeUIBag)
    }
    
    // MARK: - Setup UI
    func setupUI(){
        setupTableView()
        setupSearchBar()
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        
        var topAnchor: NSLayoutYAxisAnchor!
        var bottomAnchor: NSLayoutYAxisAnchor!
        
        if #available(iOS 11.0, *) {
            topAnchor = self.view.safeAreaLayoutGuide.topAnchor
            bottomAnchor = self.view.safeAreaLayoutGuide.bottomAnchor
        } else {
            topAnchor = self.view.topAnchor
            bottomAnchor = self.view.bottomAnchor
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupSearchBar() {
        searchBar.searchBarStyle = .prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.backgroundImage = UIImage()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    //MARK: UI Methods
    
    func filterAlreadySelectedCurrencies() {
        guard self.currenciesToIgnore.count > 0 else {return}
        self.currencies = self.currencies.filter({[weak self] currency -> Bool in
            guard let self = self else {return true}
            return self.currenciesToIgnore.contains { $0.code != currency.code }
        })
    }
    
    func ordenateByCode() {
        self.currencies.sort { $0.code < $1.code }
    }
}

extension CurrencySelectorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return self.filteredCurrencies.count
        }
        return self.currencies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currencies = isSearching ? self.filteredCurrencies : self.currencies
        let cell = UITableViewCell()
        cell.textLabel?.text = currencies[indexPath.row].code + " - " + currencies[indexPath.row].name.capitalized
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currencies = isSearching ? self.filteredCurrencies : self.currencies
        if self.isSelectingFirstCurrency {
            self.viewModel.setFirstCurrency(currencies[indexPath.row])
        } else {
            self.viewModel.setSecondCurrency(currencies[indexPath.row])
        }
        self.dismiss(animated: true)
    }
}
extension CurrencySelectorViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isSearching = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.isSearching = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filteredCurrencies = self.currencies.filter({ currency -> Bool in
            currency.name.lowercased().contains(searchText.lowercased()) || currency.code.lowercased().contains(searchText.lowercased())
        }).sorted(by: { $0.code < $1.code })
        self.tableView.reloadData()
    }
}
