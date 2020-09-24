//
//  CurrencyConverter.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 13/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import Foundation



class CurrencyConverter {
   
    func convertToSelectedCurrency(_ dollarOrigin:Double, _ dollarDestiny:Double, _ amount:Double) -> Double {
        return (1.0/((1.0/dollarDestiny) * dollarOrigin)) * amount
    }
        
}
