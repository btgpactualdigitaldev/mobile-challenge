//
//  CurrencyTableViewFactory.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 24/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

class CurrencyTableViewFactory: TableViewFactoryProtocol {
    
    private(set) var viewModel: CurrencyListViewModelProtocol
    
    private let tableView: UITableView
    
    init(viewModel: CurrencyListViewModelProtocol,
         tableView: UITableView) {
        self.viewModel = viewModel
        self.tableView = tableView
    }
    
    func buildSections() -> [TableViewSectionProtocol] {
        return [mainSection]
    }
    
    private var mainSection: BaseSection {
        var builders: [CurrencyListTableViewCellBuilder] = []
        let list = viewModel.filteredCurrencyList
        for currency in list {
            builders.append(CurrencyListTableViewCellBuilder(currencyAttrString: currency))
        }
        return BaseSection(builders: builders, tableView: tableView)
    }
}
