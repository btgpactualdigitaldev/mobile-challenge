//
//  Calculator.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 12/12/20.
//

import Foundation

struct Calculator {
  var exanges: [String:Double]
  var fromDollarToCurrecy = 0
  var toDollarToCurrecy = 0
  var dollarCurrencyResult = 0
  
  func extractCurrecy(currecyString: String) -> String {
    return String(currecyString.suffix(3))
  }
  
  func exanges(valueToConvert: Double, currecyToConvert: String, currencyFromConvert: String)-> Double {
    var total = 0.0
    var dollarValue = 0.0
    
    for (key, value) in exanges {
      let fromCurrencyCode = extractCurrecy(currecyString: key)
      if(currencyFromConvert == fromCurrencyCode){
        dollarValue = valueToConvert/value
      }
    }
    
    for (key, value) in exanges {
      let toCurrencyCode = extractCurrecy(currecyString: key)
      if(currecyToConvert == toCurrencyCode){
        total = dollarValue*value
      }
    }
    
    return total
  }
}
