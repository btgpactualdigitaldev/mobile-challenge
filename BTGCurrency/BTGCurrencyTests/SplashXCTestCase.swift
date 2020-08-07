//
//  SplashXCTestCase.swift
//  BTGCurrencyTests
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import XCTest

class SplashXCTestCase: XCTestCase {

    // Verificação de última consulta na API sem uma última consulta armazenada deve chamar método de sincronização
    func testCheckLastUpdateWithNoDate_shouldCallSynchronizeQuotes() {
        let currencyClient = MockCurrencyClient()
        let viewModel = SplashViewModel(currencyClient: currencyClient, userDefaults: MockUserDefaults(), networkHelper: NetworkHelper())
        viewModel.checkLastUpdate()
        XCTAssertTrue(currencyClient.synchronizeQuotesIsCalled)
    }
    
    // Verificação de última consulta na API com uma data e hora expirada deve chamar método de sincronização
    func testCheckLastUpdateWithExpiredDate_shouldNotCallSynchronizeQuotes() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        
        let currencyClient = MockCurrencyClient()
        let userDefaults = UserDefaultsReturning(mockedDate: yesterday)
        let viewModel = SplashViewModel(currencyClient: currencyClient, userDefaults: userDefaults, networkHelper: NetworkHelper())
        viewModel.checkLastUpdate()
        XCTAssertTrue(currencyClient.synchronizeQuotesIsCalled)
    }
    
    // Verificação de última consulta na API com uma data e hora não expirada não deve chamar método de sincronização
    func testCheckLastUpdateWithNonExpiredDate_shouldNotCallSynchronizeQuotes() {
        let now = Date()
        
        let currencyClient = MockCurrencyClient()
        let userDefaults = UserDefaultsReturning(mockedDate: now)
        let viewModel = SplashViewModel(currencyClient: currencyClient, userDefaults: userDefaults, networkHelper: NetworkHelper())
        viewModel.checkLastUpdate()
        XCTAssertFalse(currencyClient.synchronizeQuotesIsCalled)
    }

}
