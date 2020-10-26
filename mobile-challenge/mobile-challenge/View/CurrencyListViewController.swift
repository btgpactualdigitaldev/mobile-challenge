//
//  CurrencyListViewController.swift
//  mobile-challenge
//
//  Created by Matheus Brasilio on 24/10/20.
//  Copyright © 2020 Matheus Brasilio. All rights reserved.
//

import UIKit

public protocol CurrencyListViewControllerDelegate {
    func selectCurrencyOnClick(currencyToBeSelect: CurrencyToBeSelect, currency: Currency)
}

public enum CurrencyToBeSelect {
    case originalCurrency, targetCurrency
}

class CurrencyListViewController: UIViewController {
    // MARK: - Attributes
    fileprivate var viewModel: CurrencyViewModel?
    fileprivate var currencyToBeSelect: CurrencyToBeSelect?
    public var delegate: CurrencyListViewControllerDelegate?
    
    // MARK: - Layout Attributes
    fileprivate let tableView: UITableView = {
        let tv = UITableView(frame: CGRect.zero, style: .grouped)
        tv.backgroundColor = .clear
        tv.separatorStyle = .singleLine
        tv.separatorColor = UIColor.black.withAlphaComponent(0.6)
        tv.separatorInset = UIEdgeInsets.init(top: CurrencyListTableViewCell.cellHeight, left: 0, bottom: 0, right: 0)
        tv.showsVerticalScrollIndicator = false
        tv.estimatedRowHeight = CurrencyListTableViewCell.cellHeight
        tv.register(CurrencyListTableViewCell.self, forCellReuseIdentifier: CurrencyListTableViewCell.cellIdentifier)
        return tv
    }()

    // MARK: - View Lifecycle
    init(viewModel: CurrencyViewModel, currencyToBeSelect: CurrencyToBeSelect) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.currencyToBeSelect = currencyToBeSelect
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "lista de moedas".uppercased()
        self.view.backgroundColor = UIColor.white
        setupConstraints()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Layout Functions
    fileprivate func setupConstraints() {
        self.view.addSubview(tableView)
        tableView.anchor(
            top: (self.view.topAnchor, 0),
            left: (self.view.leftAnchor, 24),
            right: (self.view.rightAnchor, 24),
            bottom: (self.view.bottomAnchor, 0)
        )
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension CurrencyListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let viewModel = viewModel, let currencyList = viewModel.currencyList {
            return currencyList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel, let currencyList = viewModel.currencyList, indexPath.row < currencyList.count else { return UITableViewCell() }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListTableViewCell.cellIdentifier) as? CurrencyListTableViewCell else { return UITableViewCell() }
        
        let currency = currencyList[indexPath.row]
        cell.setup(title: currency.name, symbol: currency.symbol)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = self.viewModel, let currencyList = viewModel.currencyList, let currencyToBeSelect = self.currencyToBeSelect, let delegate = self.delegate, indexPath.row < currencyList.count else { return }
        let currency = currencyList[indexPath.row]
        delegate.selectCurrencyOnClick(currencyToBeSelect: currencyToBeSelect, currency: currency)
        self.navigationController?.popViewController(animated: true)
    }
}
