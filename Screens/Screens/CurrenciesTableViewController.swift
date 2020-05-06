//
//  CurrenciesTableViewController.swift
//  Screens
//
//  Created by Gustavo Amaral on 01/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import UIKit
import Models
import Combine

class CurrenciesTableViewController: UITableViewController, Drawable {
    
    var currencies = [Currency]() { didSet { filteredCurrencies = currencies } }
    private var filteredCurrencies = [Currency]() { didSet { tableView.reloadData() } }
    weak var delegate: CurrenciesTableViewControllerDelegate?
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        draw()
    }
    
    func stylizeViews() {
        tableView.backgroundColor = #colorLiteral(red: 0.2119999975, green: 0.2630000114, blue: 0.3330000043, alpha: 1)
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2119999975, green: 0.2630000114, blue: 0.3330000043, alpha: 1)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.view.backgroundColor = #colorLiteral(red: 0.2119999975, green: 0.2630000114, blue: 0.3330000043, alpha: 1)
        navigationController?.navigationItem.searchController?.searchBar.tintColor = .init(white: 1, alpha: 0.8)
        navigationItem.hidesSearchBarWhenScrolling = false
        let searchBarAppearance = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        searchBarAppearance.textColor = .init(white: 1, alpha: 0.8)
        let magnifying = UIImageView.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        magnifying.tintColor = .init(white: 1, alpha: 0.8)
        let cancelButton = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        cancelButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor(white: 1, alpha: 0.8)], for: .normal)
    }
    
    func createViewsHierarchy() {
        tableView.register(Cell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.allowsSelection = true
        tableView.separatorStyle = .none
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocorrectionType = .yes
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationController?.navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.searchController = searchController
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = filteredCurrencies[indexPath.row]
        delegate?.controller(self, didSelect: currency)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 91
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCurrencies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let genericCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        guard let cell = genericCell as? Cell else { fatalError("The type of cells must be Cell") }
        
        if cell.abbreviation == nil { cell.draw() }
        
        let currency = filteredCurrencies[indexPath.row]
        cell.abbreviation.text = currency.abbreviation
        cell.abbreviation.accessibilityIdentifier = currency.abbreviation
        cell.fullName.text = currency.fullName
        
        return cell
    }
}

extension CurrenciesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else { return }
        guard !searchText.isEmpty else {
            filteredCurrencies = currencies
            return
        }
        
        currencies.search(for: searchText, at: (\Currency.abbreviation, 2), (\Currency.fullName, 1))
            .receive(on: DispatchQueue.main)
            .assign(to: \.filteredCurrencies, on: self)
            .store(in: &cancellables)
    }
}

fileprivate class Cell: UITableViewCell, Drawable {
    
    private(set) weak var abbreviation: UILabel!
    private(set) weak var fullName: UILabel!
    private weak var bottomLine: UILabel!
    
    func makeConstraints() {
        abbreviation.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(36)
            make.top.equalTo(snp.top).offset(20.5)
        }
        
        fullName.snp.makeConstraints { make in
            make.leading.equalTo(abbreviation.snp.leading)
            make.top.equalTo(abbreviation.snp.bottom)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.leading.equalTo(snp.leading).offset(16)
            make.trailing.equalTo(snp.trailing).inset(16)
            make.bottom.equalTo(snp.bottom)
            make.height.equalTo(1)
        }
    }
    
    func stylizeViews() {
        abbreviation.font = .sfPro(.title1(.plain))
        abbreviation.textColor = .white
        abbreviation.alpha = 0.8
        
        fullName.font = .sfPro(.title3(.plain))
        fullName.textColor = .white
        fullName.alpha = 0.36
        
        bottomLine.backgroundColor = #colorLiteral(red: 0.4390000105, green: 0.4390000105, blue: 0.4390000105, alpha: 1)
        bottomLine.alpha = 0.45
        backgroundColor = .clear
    }
    
    func createViewsHierarchy() {
        let abbreviation = UILabel()
        self.abbreviation = abbreviation
        addSubview(abbreviation)
        
        let fullName = UILabel()
        self.fullName = fullName
        addSubview(fullName)
        
        let bottomLine = UILabel()
        self.bottomLine = bottomLine
        addSubview(bottomLine)
    }
}

protocol CurrenciesTableViewControllerDelegate: AnyObject {
    func controller(_ controller: CurrenciesTableViewController, didSelect currency: Currency)
}

fileprivate let cellIdentifier = "cellIdentifier"
