//
//  CurrencyListView.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 27/11/20.
//

import UIKit

class CurrencyListView: UIView {
    
    var searchBar: UISearchBar = {
        let search = UISearchBar(frame: .zero)
        search.placeholder = CurrencyListStrings.searchPlaceHolder.text
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.tintColor = CurrencyListColors.code.color
        search.searchTextField.returnKeyType = .search
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(CurrencyCell.self, forCellReuseIdentifier: CurrencyCell.identifier)
        tableView.register(LoadingCell.self, forCellReuseIdentifier: LoadingCell.identifier)
        tableView.register(EmptyCell.self, forCellReuseIdentifier: EmptyCell.identifier)
        tableView.register(CurrencyListHeader.self, forHeaderFooterViewReuseIdentifier: CurrencyListHeader.identifier)
        tableView.separatorStyle = .singleLine
        tableView.backgroundColor = AppColors.appBackground.color
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrencyListView: ViewCodable {
    func setUpHierarchy() {
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setUpAditionalConfiguration() {
        backgroundColor = AppColors.appBackground.color
    }
}
