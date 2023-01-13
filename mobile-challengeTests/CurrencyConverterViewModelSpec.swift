//
//  CurrencyConverterViewModelSpec.swift
//  mobile-challengeTests
//
//  Created by Brunno Andrade on 06/10/20.
//

import XCTest
@testable import mobile_challenge

class CurrencyConverterViewModelSpec: XCTestCase {
    
    var currencyConverterVM: CurrencyConverterViewModel!
    var quoteListMock: QuoteList!

    override func setUpWithError() throws {
        currencyConverterVM = CurrencyConverterViewModel()
        
        quoteListMock = QuoteList(success: true, error: nil, source: nil, quotes: ["USDAED": 3.673198, "USDAFN": 76.89408])
        currencyConverterVM.setQuotesArray(quoteList: quoteListMock)
    }

    override func tearDownWithError() throws {
        currencyConverterVM = nil
    }

    func testArrayQuotes() {

        XCTAssertEqual(2, currencyConverterVM.quotes.count)
    }
    
    func testSelectedQuoteOrigin() {
        
        currencyConverterVM.quoteSelect(type: .origin, code: "AED")
        
        XCTAssert((currencyConverterVM.selectedOrigin != nil), "Origin not selected")
        XCTAssertEqual("AED", currencyConverterVM.selectedOrigin?.code)
    }

    func testSelectedQuoteDestiny() {
        
        currencyConverterVM.quoteSelect(type: .destiny, code: "AED")
        
        XCTAssert((currencyConverterVM.selectedDestiny != nil), "Destiny not selected")
        XCTAssertEqual("AED", currencyConverterVM.selectedDestiny?.code)
    }
    
    func testSearchQuoteByCode() {
        
        let quote = currencyConverterVM.searchQuote(with: "AFN")
   
        XCTAssertEqual("AFN", quote?.code)
    }
    
    
    func testConverterCurrencyErrorNotOrigin() {
   
        let value = currencyConverterVM.converterCurrency(1.00)
        
        XCTAssertEqual(value, "Não foi possivel fazern a conversão dos valores.")
    }
    
    func testConverterCurrencyErrorNotDestiny() {
        
        currencyConverterVM.quoteSelect(type: .destiny, code: "AED")
   
        let value = currencyConverterVM.converterCurrency(1.00)
        
        XCTAssertEqual(value, "Não foi possivel fazern a conversão dos valores.")
    }
    
    func testConverterCurrencySuccess() {
        
        currencyConverterVM.quoteSelect(type: .origin, code: "AED")
        currencyConverterVM.quoteSelect(type: .destiny, code: "AFN")
   
        let value = currencyConverterVM.converterCurrency(1.00)
        
        XCTAssertEqual(value, "20.93")
    }
    
    func testConverterCurrencySuccessDollarOrigin() {
        
        let quotesMockDolar: QuoteList = QuoteList(success: true, error: nil, source: nil, quotes: ["USDUSD": 1, "USDBRL": 5.690])
        
        currencyConverterVM.setQuotesArray(quoteList: quotesMockDolar)
        
        currencyConverterVM.quoteSelect(type: .origin, code: "USD")
        currencyConverterVM.quoteSelect(type: .destiny, code: "BRL")
   
        let value = currencyConverterVM.converterCurrency(1.00)
        
        XCTAssertEqual(value, "5.69")
    }

}
