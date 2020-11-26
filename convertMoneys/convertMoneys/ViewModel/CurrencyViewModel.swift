//
//  CurrencyViewModel.swift
//  convertMoneys
//
//  Created by Mateus Rodrigues Santos on 25/11/20.
//

import Foundation

class CurrencyViewModel:AnswerAllCurrencies {
    
    var allCurrencies:[Int:String] = [:]
    
    func configureAllCurrencies(){
        let resp = self.currencies(url: URLs.allCurrencies)
        
        allCurrencies = resp
    }
}
