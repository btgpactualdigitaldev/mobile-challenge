//
//  CurrencyDAOSpec.swift
//  CurrencyExchangeTests
//
//  Created by Carlos Fontes on 02/11/20.
//

import Foundation
@testable import CurrencyExchange
import Quick
import Nimble
import CoreData

class CurrencyDAOSpec: QuickSpec {
    
    override func spec() {
        var sut: CurrencyDAO!
        var contextCD: NSManagedObjectContext!
        
        beforeEach {
            contextCD = CoreDataStack.shared.mockPersistantContainer.viewContext
            sut = CurrencyDAO(context: contextCD)
        }
        
        describe("Currency DAO"){
            context("save new currency on core data"){
                it("should create a currency"){
                    let currency = Currency(name: "Brazilian Real", code: "BRL", value: 5.74)
                    sut.createWithCurrency(currency)
                    
                    var actualCurrencies: [Currency]?
                    do {
                        try sut.fetchWithPredicate(nil, withSortDescriptors: nil) { (currencies) in
                            
                            actualCurrencies = currencies
                        }
                    }catch {
                      print("Error")
                    }
                    
                    expect(currency.name).to(equal(actualCurrencies?[0].name))
                }
            }
        }
    }
    
    
}
