//
//  ListQuotesViewController.swift
//  BTGDasafio
//
//  Created by leonardo fernandes farias on 29/08/20.
//  Copyright © 2020 leonardo. All rights reserved.
//

import UIKit

protocol ListQuoteDelegate: class {
    func didSelectedCurrency(for currency: Currency)
}

class ListQuotesViewController: UIViewController {
    var viewModel: ListQuotesViewModel = ListQuotesViewModel(currencyList: [])
    weak var delegate: ListQuoteDelegate?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
    }
    
    func configureTable() { tableView.tableFooterView = UIView(frame: .zero) }
}

extension ListQuotesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.cellTitle(at: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = viewModel.currency(at: indexPath.row) else { return }
        delegate?.didSelectedCurrency(for: currency)
        dismiss(animated: true, completion: nil)
    }
}
