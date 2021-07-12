//
//  CurrencyVM.swift
//  mobileChallenge
//
//  Created by Mateus Augusto M Ferreira on 26/11/20.
//

import Foundation
import UIKit

//MARK: -Enum
enum ErrorViewModel: Error{
    case failConvertion
    case zero
}

//MARK: -Class
/// Currency Data View Model
class CurrencyDataVM {
    
    //MARK: Variables
    var quoteFirst:Double = 0.0
    var quoteSecond:Double = 0.0
    
    //MARK: -Functions
    /// Configure Currency Name
    /// - Parameters:
    ///   - atualNameCurrency: actual Name
    ///   - view: view description
    ///   - destiny: destiny description
    ///   - quote: quote description
    func configureCurrencyName(_ atualNameCurrency: String, _ view: CurrencyView, _ destiny: CurrencyViewModelReceiver, _ quote: Double){
        if atualNameCurrency == "USDUSD"{
            if destiny == .currencyOrigin{
                view.firstCurrencyButton.titleLabel?.text = "USD"
                quoteFirst = quote
            }else{
                quoteSecond = quote
                view.secondCurrencyButton.titleLabel?.text = "USD"
            }
        }else{
            let newNameCurrency = atualNameCurrency.components(separatedBy: "USD")
            
            if destiny == .currencyOrigin{
                guard ((view.firstCurrencyButton.titleLabel?.text = newNameCurrency[0]) != nil) else{
                    return
                }
                quoteFirst = quote
            }else{
                quoteSecond = quote
                guard ((view.secondCurrencyButton.titleLabel?.text = newNameCurrency[0]) != nil) else{
                    return
                }
            }
        }
    }
    
    /// Show values
    /// - Parameters:
    ///   - valueConvertion: value Convertion
    ///   - firstName: first value
    ///   - secondName: second value
    /// - Throws: Exception
    /// - Returns: return conversion
    func convert(valueConvertion:Double,firstName:String,secondName:String) throws -> Double{
        
        if firstName == "Currency 1" || secondName == "Currency 2"{
            throw ErrorViewModel.failConvertion
        }else if  valueConvertion == 0.0{
            throw ErrorViewModel.zero
        }else{
            
            //Para dolar USD
            if secondName == "USD" {
                return valueConvertion * quoteFirst
            }
            
            if firstName == "USD"{
                return valueConvertion * quoteSecond
            }
            
            //Convert in Dollar
            let dolar = valueConvertion / quoteFirst
           
            //Calculate
            let result = (dolar * quoteSecond)
        
            return result
        }
    }
    
}
