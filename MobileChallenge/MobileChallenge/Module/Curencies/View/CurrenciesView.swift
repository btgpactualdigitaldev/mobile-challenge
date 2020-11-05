//
//  CurrenciesView.swift
//  MobileChallenge
//
//  Created by Jonatas Coutinho de Faria on 03/11/20.
//


import UIKit

class CurrenciesView: UIView{
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        
        return button
    }()
    
    lazy var modalNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: .zero)
        
        let navItem = UINavigationItem(title: "Select the Currency")
        
        navItem.leftBarButtonItem = cancelBarButton
        
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    lazy var currenciesTableView: UITableView = {
        let tableView = UITableView(frame: self.frame)
        tableView.register(CurrenciesViewCell.self, forCellReuseIdentifier: CurrenciesViewCell.uniqueIdentifier)
        tableView.tableHeaderView = searchBarController.searchBar
        return tableView
    }()
    
    lazy var searchBarController: UISearchController = {
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    lazy var loadIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: self.frame)
        activityIndicator.style = .large
        
        return activityIndicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CurrenciesView: ViewCodable{
    
    func setupViewHierarchy() {
        self.addSubview(currenciesTableView)
        self.addSubview(modalNavigationBar)
        currenciesTableView.addSubview(loadIndicator)
    }
    
    func setupConstraints() {
        
        // Navgation Bar Anchors
        self.modalNavigationBar.anchor(top: topAnchor)
        self.modalNavigationBar.anchor(left: leftAnchor)
        self.modalNavigationBar.anchor(right: rightAnchor)
        
        // Table View Anchors
        self.currenciesTableView.anchor(top: self.modalNavigationBar.bottomAnchor, paddingTop: 0)
        self.currenciesTableView.anchor(bottom: self.bottomAnchor, paddingBottom: 0)
        self.currenciesTableView.anchor(left: self.leftAnchor, paddingLeft: 0)
        self.currenciesTableView.anchor(right: self.rightAnchor, paddingRight: 0)
    }
}
