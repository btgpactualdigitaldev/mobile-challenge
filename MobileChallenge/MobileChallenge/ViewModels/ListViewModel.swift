//
//  ListViewModel.swift
//  MobileChallenge
//
//  Created by Vitor Gomes on 07/09/21.
//

import Foundation

protocol ListViewModelDelegate: AnyObject {
    
    func didSuccess(bool: Bool?)
}

class ListViewModel {
    
    var network = Network()
    
    var currenciesDictionary: [String:String] = [:]
    var keys: [String] = []
    var values: [String] = []
    var quotes: [String:Double] = [:]
    var source: String?
    
    weak var delegate: ListViewModelDelegate?
    
    func getListData() {
        
        network.getListData { success, error in
            if success?.success == true {
                self.currenciesDictionary = success?.currencies ?? [:]
                self.getKeyArray()
                self.getValuesArray()
                self.delegate?.didSuccess(bool: true)
            } else {
                print(error)
            }
        }
    }
    
    func getLiveData() {
        
        network.getLiveData { success, error in
            if success?.success == true {
                self.quotes = success?.quotes ?? [:]
                self.source = success?.source
            } else {
                print(error)
            }
        }
    }
    
    func getValuesArray() {
        for i in currenciesDictionary.values {
            values.append(i)
        }
    }
    
    func getKeyArray() {
        for i in currenciesDictionary.keys {
            keys.append(i)
        }
    }
    
    func exchange(value: Double, origin: String?, destination: String?) -> String {
        let originQuote = quotes["\(source ?? "")\(origin ?? "")"] ?? 0
        let destinationQuote = quotes["\(source ?? "")\(destination ?? "")"]
        
        let convert = value / originQuote
        let calculateExchange = convert * (destinationQuote ?? 0)
        
        let finalNumber = String(format: "%.2f", calculateExchange)
        
        return finalNumber.description
    }
}


