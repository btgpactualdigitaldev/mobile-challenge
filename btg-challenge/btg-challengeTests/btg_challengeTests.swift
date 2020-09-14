//
//  btg_challengeTests.swift
//  btg-challengeTests
//
//  Created by Wesley Araujo on 13/09/20.
//  Copyright © 2020 Wesley Araujo. All rights reserved.
//

import XCTest
@testable import btg_challenge

class btg_challengeTests: XCTestCase {
    
    func testGetCurrencyResult() {
        // Given
        let mainViewModel = MainViewModel()
        let value = 15.0
        
        // When
        let convertedValue = mainViewModel.convertCurrency(from: "BRL", to: "USD", withValue: value)
        
        // Then
        XCTAssertEqual(value / ((mainViewModel.live?.quotes!["USDBRL"])!), convertedValue)
    }
    
    func testConvertAmountToDollarWithQuoteGreaterThanDollar() {
        // Given
        let amount = 15.0
        let quote = 5.31
        let convertedAmount = 2.82 // Dólares
        
        // When
        let dollarAmount = amount.convertToDollar(by: quote)
        
        // Then
        XCTAssertEqual(convertedAmount, dollarAmount.rounded(toPlaces: 2))
    }
    
    func testConvertAmountToDollarWithLessThanDollar() {
        // Given
        let amount = 15.0
        let quote = 0.84
        let convertedAmount = 12.60
        
        // When
        let dollarAmount = amount.convertToDollar(by: quote)
        
        // Then
        XCTAssertEqual(convertedAmount, dollarAmount.rounded(toPlaces: 2))
    }
    
    func testConvertDollarToAnotherCurrencyAmount() {
        // Given
        let amount = 15.0 // Dólares
        let quote = 0.84 // Cotação euro
        let convertedValueAmount = 12.60
        
        // When
        let amountCurrency = amount.convertDollarToCurrency(by: quote)
        
        // Then
        XCTAssertEqual(convertedValueAmount, amountCurrency.rounded(toPlaces: 2))
    }
    
    func testConvertDollarToAnotherCurrency() {
        // Given
        let amount = 2.82 // Dólares
        let quote = 0.84 // Cotação euro
        
        // When
        let amountCurrency = amount.convertDollarToCurrency(by: quote)
        
        // Then
        XCTAssertEqual(amount * quote, amountCurrency)
    }
    
    func testConvertCurrency() {
        // Given
        let amountBRL = 15.0 // Reais
        let quoteUSDBRL = 5.31 //
        let quoteUSDEUR = 0.84 // Cotação USD - Euro
        let convertedValueAmount = 2.37 // Valor em Euros
        
        // When
        let amountCurrency = amountBRL.convertToCurrency(quoteSource: quoteUSDBRL, quoteDestiny: quoteUSDEUR)
        
        // Then
        XCTAssertEqual(convertedValueAmount, amountCurrency.rounded(toPlaces: 2))
    }
    
    func testSelectCurrentQuote() {
        // Given
        let mainViewModel = MainViewModel()
        
        // When
        let currentSourceCurrency = mainViewModel.selectCurrencyQuote(from: "BRL")
        
        // Then
        XCTAssertEqual(currentSourceCurrency, ["USDBRL": 5.31])
    }
    
    func testSelectDestinyCurrency() {
        // Given
        let mainViewModel = MainViewModel()
        
        // When
        let currentDestinyCurrency = mainViewModel.selectDestinyCurrency("BRL")
        
        // Then
        XCTAssertEqual(currentDestinyCurrency, ["USDBRL": 5.31])
    }

}
