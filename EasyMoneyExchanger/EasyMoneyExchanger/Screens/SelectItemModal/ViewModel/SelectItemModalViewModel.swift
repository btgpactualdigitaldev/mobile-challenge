//
//  SelectItemModalViewModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 13/12/20.
//

import Foundation
import UIKit

class SelectItemModalViewModel: DataConverter {

    let coreData: CoreDataManager
    var supportedList: [SupportedList]?
    var supportedListSearch: [SupportedList]?

    init(coreData: CoreDataManager) {
        self.coreData = coreData
    }

    func initSupportedList(uiTableView tableView: UITableView) {
        supportedList = getSupportedList(supportedDictionary: getCoreDataSupported(uiTableView: tableView)!)
        supportedList = sortSupportedList(supportedList: supportedList!)
        supportedList = addSupportedListFlags(supportedList: supportedList!)
        supportedListSearch = supportedList
    }

    func getCoreDataSupported(uiTableView: UITableView) -> [String: String]? {
        coreData.getSupported(tableView: uiTableView)
        coreData.getRates(tableView: uiTableView)
        return coreData.supportedItems?[0].currencies
    }

    func addSelectedItem(uiTableView tableView: UITableView, selectedItem: String, selected: ButtonType, delegate: UpdateLabels?) {
        coreData.getExchanges(tableView: tableView)

        // Check Selected
        if selected == ButtonType.to {
            coreData.updateExchangeTo(tableView: tableView, to: selectedItem)
            delegate?.updateTo(to: selectedItem)
        } else {
            coreData.updateExchangeFrom(tableView: tableView, from: selectedItem)
            delegate?.updateFrom(from: selectedItem)
        }
    }

    // Filter a list of items based on given text
    func filterSearchbarList(list: [SupportedList], searchText: String ) -> [SupportedList] {
        return  list.filter {$0.currencyName.contains(searchText) || $0.currencyCode.contains(searchText)}
    }
}
