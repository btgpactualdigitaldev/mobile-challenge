//
//  CurrencyData.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 03/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation
import RealmSwift

class CurrencyData {
    static let realm = try! Realm()
    
    class func save(quotesResponse: CurrencyQuoteResponse, namesResponse: CurrencyNameResponse) -> Bool {
        let currencies = getModelList(quotesResponse: quotesResponse, namesResponse: namesResponse)
        
        do {
            try realm.write {
                realm.add(currencies, update: .all)
            }
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    class func getAll() -> Results<Currency> {
        return realm.objects(Currency.self)
    }
    
    class func get(forAbbreviation abbreviation: String) -> Currency? {
        realm.object(ofType: Currency.self, forPrimaryKey: abbreviation)
    }
    
    fileprivate class func getModelList(quotesResponse: CurrencyQuoteResponse, namesResponse: CurrencyNameResponse) -> [Currency] {
        var currencies = [Currency]()
        
        for (abbreviation, name) in namesResponse.currencies {
            let currency = Currency()
            currency.abbreviation = abbreviation
            currency.name = name
            currency.usdQuote = getQuote(in: quotesResponse, forAbbreviation: abbreviation)
            currencies.append(currency)
        }
        
        return currencies
    }
    
    fileprivate class func getQuote(in quotesResponse: CurrencyQuoteResponse, forAbbreviation abreviation: String) -> Double {
        for (exchange, quote) in quotesResponse.quotes {
            // Transforma USDBRL em BRL
            let quoteAbbreviation = exchange.replacingOccurrences(of: quotesResponse.source, with: "")
            if quoteAbbreviation == abreviation {
                return quote
            }
        }
        // Se não encontrou é por que é o próprio USD
        return 1
    }
}
