//
//  CurrencyListView.swift
//  CurrencyExchange
//
//  Created by Carlos Fontes on 29/10/20.
//

import UIKit

class CurrencyListView: UIView, ActivityIndicator {
    
    // MARK: - Properties
    
    lazy var modalNavigationBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: .zero)
        navBar.barTintColor = .white
        navBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        let navItem = UINavigationItem(title: "Escolha uma moeda")
        navItem.leftBarButtonItem = cancelBarButton
        
        navBar.setItems([navItem], animated: false)
        return navBar
    }()
    
    lazy var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: nil)
        button.tintColor = .black
        return button
    }()
    
    let tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(CurrencyListTableViewCell.self, forCellReuseIdentifier: CurrencyListTableViewCell.uniqueIdentifier)
        view.backgroundColor = .clear
        return view
    }()
    
    var loadingIndicatorView: UIView?
    
    var activityIndicator: UIActivityIndicatorView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupViews()
    }
    
    private func setupUI(){
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - View Codable Protocol

extension CurrencyListView: ViewCodable {
    
    func setupViewHierarchy() {
        self.addSubview(modalNavigationBar)
        self.addSubview(tableView)
    }
    
    func setupConstraints() {
        self.setupTableViewConstraints()
        self.setupModalNavigationBarConstraints()
    }
    
    private func setupModalNavigationBarConstraints(){
        self.modalNavigationBar.anchor(top: topAnchor)
        self.modalNavigationBar.anchor(left: leftAnchor)
        self.modalNavigationBar.anchor(right: rightAnchor)
        self.modalNavigationBar.anchor(height: 44)
    }
    
    private func setupTableViewConstraints(){
        self.tableView.anchor(top: modalNavigationBar.bottomAnchor, paddingTop: ScreenSize.height * 0.01)
        self.tableView.anchor(left: leftAnchor)
        self.tableView.anchor(right: rightAnchor)
        self.tableView.anchor(bottom: bottomAnchor)
    }
}
