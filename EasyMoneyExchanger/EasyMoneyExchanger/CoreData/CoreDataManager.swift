//
//  CoreDataManager.swift
//  EasyMoneyExchanger
//
//  Created by Leon on 10/12/20.
//

import Foundation
import UIKit

class CoreDataManager {
    let context =  (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    var supportedItems: [Supported]?
    var rateItems: [Rates]?
    var exchangeItems: [Exchanges]?

    // MARK: - Core Data Add

    func addSupportedCurrencies(tableView: UITableView, supprtedCurrencies: CurrencySupported) {
        let newSupportedCurrencies = Supported(context: self.context!)
        newSupportedCurrencies.currencies = supprtedCurrencies.currencies
        supportedItems = [newSupportedCurrencies]
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    func addRates(tableView: UITableView, realtimeRates: CurrencyRates) {
        let newCurrencyRates = Rates(context: self.context!)
        newCurrencyRates.quotes = realtimeRates.quotes
        newCurrencyRates.timeStamp = Int64(realtimeRates.timestamp)
        rateItems = [newCurrencyRates]
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    func addExchanges(tableView: UITableView, from: String, to: String) {
        let newCurrencyToConvert = Exchanges(context: self.context!)
        newCurrencyToConvert.to = to
        newCurrencyToConvert.from = from
        exchangeItems = [newCurrencyToConvert]
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    // MARK: - Core Data Get

    func getSupported(tableView: UITableView) {
        do {
            self.supportedItems = try context?.fetch(Supported.fetchRequest())
            DispatchQueue.main.async {
                tableView.reloadData()
            }

        } catch {

        }
    }

    func getRates(tableView: UITableView) {
        do {
            self.rateItems = try context?.fetch(Rates.fetchRequest())
            DispatchQueue.main.async {
                tableView.reloadData()
            }

        } catch {

        }
    }

    // Fetch Core Data Currencies To Convert
    func getExchanges(tableView: UITableView) {
        do {
            self.exchangeItems = try context?.fetch(Exchanges.fetchRequest())
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    // MARK: - Core Data Update

    func updateSupported(tableView: UITableView, supportedCurrencies: CurrencySupported) {
        let localCoreCurrencySupportedItems = self.supportedItems![0]
        localCoreCurrencySupportedItems.currencies = supportedCurrencies.currencies
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    func updateRates(tableView: UITableView, currencyRates: CurrencyRates) {
        let localCoreRealtimeRates = self.rateItems![0]
        localCoreRealtimeRates.quotes = currencyRates.quotes
        localCoreRealtimeRates.timeStamp = Int64(currencyRates.timestamp)
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    func updateExchangeFrom(tableView: UITableView, from: String) {
        let localCoreRealtimeRates = self.exchangeItems![0]
        localCoreRealtimeRates.from = from
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }

    func updateExchangeTo(tableView: UITableView, to: String) {
        let localCoreRealtimeRates = self.exchangeItems![0]
        localCoreRealtimeRates.to = to
        //Save Data
        do {
            try self.context?.save()
            DispatchQueue.main.async {
                tableView.reloadData()
            }
        } catch {

        }
    }
}
