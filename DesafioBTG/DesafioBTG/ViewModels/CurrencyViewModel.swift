//
//  CurrencyViewModel.swift
//  DesafioBTG
//
//  Created by Rodrigo Queiroz on 05/11/20.
//

import Foundation

class CurrencyViewModel: NSObject {
    
    private var service: ApiService!
    
    private(set) var data: Currency! {
        didSet {
            self.bindViewModel()
        }
    }
    
    var bindViewModel : (() -> ()) = {}
    
    override init() {
        super.init()
        self.service = ApiService()
        getSupportedCurrencies()
    }
    
    func getSupportedCurrencies() {
        
        self.service.getSupportedCurrencies {
            
            (response) in
            
            if response.success {
                
                var currencies = [CurrencyInfo]()
                
                
                for item in response.currencies {
                    
                    currencies.append(CurrencyInfo(item.key, item.value))
                    
                }
                
                self.data = Currency(response.success, response.terms, response.privacy, currencies)
                
            }
            
        }
    }
}
