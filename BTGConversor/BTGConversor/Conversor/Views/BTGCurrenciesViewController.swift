//
//  BTGCurrenciesViewController.swift
//  BTGConversor
//
//  Created by Franclin Cabral on 12/13/20.
//  Copyright © 2020 franclin. All rights reserved.
//

import UIKit

class BTGCurrenciesViewController: UIViewController {

    @IBOutlet weak private var tableView: UITableView!
    
    var viewModel: BTGCurrenciesViewModel
    
    init(_ viewModel: BTGCurrenciesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("This should not be used")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDelegate = self
        setupTableView()
        viewModel.fetchCurrencies()
        
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: CurrencyTableViewCell.self)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
    }

}

extension BTGCurrenciesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(class: CurrencyTableViewCell.self, indexPath: indexPath) { (cell) in
            let currency = self.viewModel.getCurrency(for: indexPath)
            cell.setup(currency)
        }
    }
    
}

extension BTGCurrenciesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didTapCurrency(at: indexPath)
        viewModel.popViewController()
    }
}

extension BTGCurrenciesViewController: BTGCurrenciesViewDelegate {
    
    func load(_ viewModel: BTGCurrenciesViewModel) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func showError(_ viewModel: BTGCurrenciesViewModel, error: BTGError) {
        
    }
}
