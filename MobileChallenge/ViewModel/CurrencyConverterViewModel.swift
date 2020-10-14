//
//  CurrencyConverterViewModel.swift
//  MobileChallenge
//
//  Created by Thiago Lourin on 13/10/20.
//

import Foundation

public class CurrencyConverterViewModel {
            
    private(set) var live: CurrencyLive! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    private(set) var error: String! {
        didSet {
            self.bindViewModelToController()
        }
    }
    
    var bindViewModelToController: (() -> ()) = {}
    
    init() {
        fetchCurrency()
    }
    
    public func convert(from: String, to: String, value: Double) -> Double {
        let mirrored = Mirror(reflecting: live.quotes.self)
        var fromValue: Double!
        var toValue: Double!
        
        mirrored.children.enumerated().forEach { (each) in
            if each.element.label?.suffix(3).contains(from) ?? false {
                fromValue = (each.element.value as! Double)
            }
            
            if each.element.label?.suffix(3).contains(to) ?? false {
                toValue = (each.element.value as! Double)
            }
        }
        
        return (toValue/fromValue) * value
    }
    
    func fetchCurrency() {
        CurrencyLiveService(delegate: self).request()
    }
}

extension CurrencyConverterViewModel: ServiceLoadedDelegate {
    func didLoad(currencyLive: CurrencyLive) {
        self.live = currencyLive
    }
    
    func error(message: String) {
        self.error = message
    }
}
