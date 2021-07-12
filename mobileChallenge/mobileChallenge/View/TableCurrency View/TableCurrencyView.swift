//
//  TableCurrencyView.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 25/11/20.
//

import Foundation
import UIKit

class TableCurrencyView: UIView {
    
    //MARK: -Variables
    //Variables
    lazy var tableCurrencyView: UITableView = {
        let tableView = UITableView(frame: self.bounds, style: .plain)
        tableView.register(TableCurrencyCell.self, forCellReuseIdentifier: Identifier.Cell.tableCurrencyCell)
        return tableView
    }()
    
    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        return searchController
    }()
    
    //MARK: -Init
    init() {
        super.init(frame: UIScreen.main.bounds)
        setupTableView()
    }
    
    //MARK: -Required Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TableCurrencyView{
    func setupTableView() {
        self.backgroundColor = .white
        self.addSubview(tableCurrencyView)
        tableCurrencyView.translatesAutoresizingMaskIntoConstraints = false
        tableCurrencyView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        tableCurrencyView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        tableCurrencyView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableCurrencyView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
}
