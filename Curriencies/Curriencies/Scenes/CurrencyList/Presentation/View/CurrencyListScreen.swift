//
//  CurrencyListScreen.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

import UIKit

fileprivate enum Layout {
    static let buttonSize: CGFloat = UIScreen.main.bounds.width / 2
}

final class CurrencyListScreen: UIView {
    typealias TableViewDelegate = UITableViewDelegate & UITableViewDataSource
    
    private let tableViewDelegate: TableViewDelegate
    private let searchBarDelegate: UISearchBarDelegate
    private let sortDelegate: SortDelegate
    
    private lazy var currencyList: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = tableViewDelegate
        tableView.delegate = tableViewDelegate
        tableView.register(CurrencyTableViewCell.self,
                           forCellReuseIdentifier: CurrencyTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private lazy var currencySearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = searchBarDelegate
        searchBar.showsCancelButton = true
        searchBar.isTranslucent = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        return searchBar
    }()
    
    private lazy var codeSorterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Código ↓", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(sortByCode),
                         for: .touchUpInside)
        
        return button
    }()
    
    private lazy var nameSorterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Nome ↓", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self,
                         action: #selector(sortByName),
                         for: .touchUpInside)
        
        return button
    }()
    
    init(tableViewDelegate: TableViewDelegate,
         searchBarDelegate: UISearchBarDelegate,
         sortDelegate: SortDelegate) {
        self.tableViewDelegate = tableViewDelegate
        self.searchBarDelegate = searchBarDelegate
        self.sortDelegate = sortDelegate
        super.init(frame: .zero)
        
        setupView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - ViewConfiguration
extension CurrencyListScreen: ViewConfiguration {
    func buildHierarchy() {
        addSubviews(views: [
            currencyList,
            currencySearchBar,
            codeSorterButton,
            nameSorterButton
        ])
    }
    
    func makeConstraints() {
        currencySearchBar
            .make([.top, .leading, .trailing], equalTo: self)
            .make(.height, equalTo: 50)
        
        codeSorterButton
            .make(.top, equalTo: currencySearchBar, attribute: .bottom)
            .make(.trailing, equalTo: self)
            .make(.width, equalTo: Layout.buttonSize)
            .make(.height, equalTo: 40)
        
        nameSorterButton
            .make(.leading, equalTo: self)
            .make([.width, .height, .top], equalTo: codeSorterButton)
        
        currencyList
            .make([.leading, .trailing, .bottom], equalTo: self)
            .make(.top, equalTo: nameSorterButton, attribute: .bottom)
    }
}

// MARK: - View Actions
@objc extension CurrencyListScreen {
    func sortByCode() {
        sortDelegate.sortList(type: .code)
    }
    
    func sortByName() {
        sortDelegate.sortList(type: .name)
    }
}

// MARK: - View Methods
extension CurrencyListScreen {
    func reloadTableView() {
        currencyList.reloadData()
    }
}
