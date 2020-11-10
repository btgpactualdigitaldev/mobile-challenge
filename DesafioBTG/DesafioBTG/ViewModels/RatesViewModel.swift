//
//  RatesViewModel.swift
//  DesafioBTG
//
//  Created by Rodrigo Goncalves on 06/11/20.
//

import Foundation

class RatesViewModel: NSObject {
    
    private var service: ApiService!
    
    private(set) var data: [Rate]! {
        didSet {
            self.bindViewModel()
        }
    }
    
    var bindViewModel: (() -> ()) = {}
    
    override init() {
        super.init()
        self.service = ApiService()
        getRealTimeRates()
    }
    
    func getRealTimeRates() {
        
        self.service.getRealTimeRates {
            
            (response) in
            
            if response.success {
                
                var rates = [Rate]()
                
                for item in response.quotes {
                    
                    rates.append(Rate(item.key, value: item.value))
                    
                }
                
                self.data = rates
                
            }
            
        }
    }
    
    
}
