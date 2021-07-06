//
//  CurrencyClientSpec.swift
//  CurrencyExchangeTests
//
//  Created by Carlos Fontes on 31/10/20.
//

import Foundation
@testable import CurrencyExchange
import Quick
import Nimble

class CurrencyClientSpec: QuickSpec {
    
    override func spec() {
        var currencyClient: CurrencyClient!
        let session = MockURLSession()
        
        beforeEach {
            currencyClient = CurrencyClient(session: session)
        }
        
        describe("Currency Api Client") {
            context("make request with an url"){
                it("should return same url"){
                    
                    guard let url = URL(string: "http://api.currencylayer.com/list?access_key=bb5801f3c4853735336e9dccd69b6905") else {
                        fatalError("URL can't be empty")
                    }
                    
                    currencyClient.getListOfCurrencies { result in
                        
                    }
                    
                    expect(session.lastURL).to(equal(url));
                    
                }
            }
            
            context("make request"){
                it("should return currencies"){

                    let expectedData = CurrencyMockData().data

                    session.data = expectedData
                    
                    var actualCurrencies: CurrencyList?
                    currencyClient.getListOfCurrencies { result in
                        switch result {

                        case .success(let currencies):
                            print(currencies)
                            actualCurrencies = currencies
                        case .failure(let error):
                            print("Error: ",error)
                        }
                    }
                    
                    expect(actualCurrencies).toNot(beNil())
                }
            }
        }
    }
}
