//
//  BTGCurrenciesAvaliableView.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation
import UIKit


class BTGCurrenciesAvaliableView: UIView {
    
    var searchBar = BTGSearchBar()
    var tableView = UITableView()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.tableView.register(BTGCurrencyCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = delegate
        self.tableView.dataSource = dataSource
    }
}


fileprivate extension BTGCurrenciesAvaliableView {
    
    func setupUI() {
        self.backgroundColor = AppStyle.Color.background
        self.tableView.backgroundColor = .clear
        
        addViews()
        setConstraints()
    }
    
    func addViews() {
        self.addSubViews(views: [
            searchBar,
            tableView
        ])
    }
    
    func setConstraints() {
        
        let layoutGuides = layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: layoutGuides.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: layoutGuides.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: layoutGuides.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: layoutGuides.bottomAnchor),
        ])
        
    }
}
