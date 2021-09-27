//
//  Mobile_ChallengeTests.swift
//  Mobile ChallengeTests
//
//  Created by Daive Costa Nardi Simões on 23/09/21.
//

import XCTest
@testable import Mobile_Challenge

class RepositoryTests: XCTestCase {

    // MARK: - Private properties
    
    private var mockedError = NSError(domain: "MockedErrorDomain", code: -999, userInfo: nil)
    private var mockedCurrentDollarQuoteDTO = CurrentDollarQuoteDTO(success: true, source: "USD", quotes: ["USDBRL" : 5.0, "USDUSD" : 1])
    private var mockedCurrenciesDTO = CurrenciesDTO(success: true, currencies: ["USD" : "Dolar Americano", "BRL" : "Real Brasileiro"])
    
    // MARK: - Repository tests
    
    func testGetCurrenciesWithSucess() {
        let useCase = ListCurrenciesUseCase(mockedCurrencyRepository: CurrencyMockedRepository(mockedCurrenciesDTO: mockedCurrenciesDTO, mockedCurrentDollarQuoteDTO: nil, mockedError: nil))
        
        useCase.list { currencies, error in
            XCTAssertNil(error)
            XCTAssertEqual(currencies?.count, 2)
        }
    }
    
    func testGetCurrenciesWithError() {
        let useCase = ListCurrenciesUseCase(mockedCurrencyRepository: CurrencyMockedRepository(mockedCurrenciesDTO: mockedCurrenciesDTO, mockedCurrentDollarQuoteDTO: nil, mockedError: mockedError))
        
        useCase.list { _ , error in
            XCTAssertNotNil(error)
        }
    }
    
    func testConverterCurrencyWithSucess() {
        let useCase = ConverterUseCase(mockedCurrencyRepository: CurrencyMockedRepository(mockedCurrenciesDTO: nil, mockedCurrentDollarQuoteDTO: mockedCurrentDollarQuoteDTO, mockedError: nil))
        
        useCase.convert(value: 1, from: "USD", to: "BRL") { quote, error in
            XCTAssertNil(error)
            XCTAssertEqual(quote, 5.0)
        }
    }
    
    func testConverterCurrencyWithError() {
        let useCase = ConverterUseCase(mockedCurrencyRepository: CurrencyMockedRepository(mockedCurrenciesDTO: nil, mockedCurrentDollarQuoteDTO: nil, mockedError: mockedError))
        
        useCase.convert(value: 1, from: "USD", to: "BRL") { quoted, error in
            XCTAssertNotNil(error)
        }
    }

}
