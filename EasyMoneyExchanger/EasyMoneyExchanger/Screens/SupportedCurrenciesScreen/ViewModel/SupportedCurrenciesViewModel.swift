//
//  CurrenciesViewModel.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 11/12/20.
//

import Foundation
import UIKit

class SupportedCurrenciesViewModel: DataConverter {

    var supportedList: [SupportedList]?
    var supportedListDictionary: [String: [SupportedList]]?
    var supportedTitles = [String]()
    var supportedListSearch: [SupportedList]?
    var isSearching = false

    let coreData: CoreDataManager

    init( coreData: CoreDataManager) {
        self.coreData = coreData
    }

    func initSupportedCurrenciesScreen(tableView: UITableView) {
        // Setup supported Items List
        initSupportedList(uiTableView: tableView)
        initSupportedTitles(uiTableView: tableView)
        initSupportedListDictionary(uiTableView: tableView)
    }

    func initSupportedList(uiTableView tableView: UITableView) {
        supportedList = getSupportedList(supportedDictionary: getCoreDataSupported(uiTableView: tableView)!)
        supportedList = sortSupportedList(supportedList: supportedList!)
        supportedList = addSupportedListFlags(supportedList: supportedList!)
    }

    func initSupportedTitles(uiTableView tableView: UITableView) {
        let localSupportedList = getSupportedList(supportedDictionary: getCoreDataSupported(uiTableView: tableView)!)
        supportedTitles = getSupportedTitles(supportedList: localSupportedList)
    }

    func initSupportedListDictionary(uiTableView tableView: UITableView) {
        var supportedListWithoutFlags = getSupportedList(supportedDictionary: getCoreDataSupported(uiTableView: tableView)!)
        supportedListWithoutFlags = sortSupportedList(supportedList: supportedListWithoutFlags)
        supportedListDictionary = getSupportedListDictionary(supportedList: supportedList!, supportedListWithoutFlags: supportedListWithoutFlags)
    }

    func getCoreDataSupported(uiTableView: UITableView) -> [String: String]? {
        coreData.getSupported(tableView: uiTableView)
        coreData.getRates(tableView: uiTableView)
        return coreData.supportedItems?[0].currencies
    }

    // Filter a list of items based on given text
    func filterSearchbarList(list: [SupportedList], searchText: String ) -> [SupportedList] {
        return  list.filter {$0.currencyName.contains(searchText) || $0.currencyCode.contains(searchText)}
    }
}
