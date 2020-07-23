//
//  ListCurrenciesTest.swift
//  CoinConversionTests
//
//  Created by Ronilson Batista on 23/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import XCTest
@testable import CoinConversion

class ListCurrenciesTest: XCTestCase {
    private var listCurrenciesViewModel: ListCurrenciesViewModel!
    private var list: [ListCurrenciesModel] = []
    
    override func setUpWithError() throws {
        listCurrenciesViewModel = ListCurrenciesViewModel(
            service: ListCurrenciesService(),
            conversion: .to,
            dataManager: DataManager(),
            router: ListCurrenciesRouter()
        )
        
        let a = ListCurrenciesModel(name: "Brazilian Real", code: "BRL")
        let b = ListCurrenciesModel(name: "BYN", code: "New Belarusian Ruble")
        let c = ListCurrenciesModel(name: "CHF", code: "Swiss Franc")
        let d = ListCurrenciesModel(name: "Colombian Peso", code: "COP")
        
        list.append(a)
        list.append(b)
        list.append(c)
        list.append(d)
    }

    override func tearDownWithError() throws {
        listCurrenciesViewModel = nil
    }

    func testFetchQuotes() {
        let exp = self.expectation(description: "Wait for Request completion")
        var fail: ServiceError?
        var list: ListCurrencies?
        
        let service = ListCurrenciesService()
        
        service.fetchListCurrencies(success: { listCurrencies in
            list = listCurrencies
            exp.fulfill()
        }) { serviceError in
            fail = serviceError
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10.0, handler: nil)
        
        XCTAssertNil(fail)
        XCTAssertNotNil(list)
        XCTAssert(list?.currencies.keys.count ?? 0 > 0, "list results")
    }
    
    func testSortByCode() {
        let sort = self.listCurrenciesViewModel.sortBy(type: .code, with: list)
        XCTAssertNotNil(sort)
    }
    
    func testSortByName() {
        let sort = self.listCurrenciesViewModel.sortBy(type: .name, with: list)
        XCTAssertNotNil(sort)
    }
}
