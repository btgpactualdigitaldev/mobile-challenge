//
//  CurrencyListTableViewDataSource.swift
//  BTG_Mobile_Challenge
//
//  Created by Pedro Henrique Guedes Silveira on 20/12/20.
//

import UIKit

final class CurrencyListTableViewDataSource: NSObject, UITableViewDataSource {
    
    private var viewModel: CurrencyListViewModel
    
    init(viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let code = viewModel.codeValueAt(indexPath: indexPath)
        let name = viewModel.nameValueAt(indexPath: indexPath)
        
        let cell = CurrencyListUITableViewCell(currencyName: name, currencyID: code)
        
        return cell
    }
}
