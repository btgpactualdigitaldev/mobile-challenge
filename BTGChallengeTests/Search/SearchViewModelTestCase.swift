//
//  SearchViewModelTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
import RxSwift
import RxTest
@testable import BTGChallenge

class SearchViewModelTestCase: XCTestCase {
    
    var sut: SearchViewModel!
    var service: SearchServiceStub!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        service = SearchServiceStub()
        sut = SearchViewModel(service: service)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
    
    func testFetchQuotes() {
        service.result = [
            "BRL": "Brazilian Real"
        ]
        sut.fechCurrencys()
        XCTAssertEqual(sut.listCurrency.first?.key, "BRL")
    }
    
    func testFetchQuotesErro() {
        service.result = [
            "BRL": "Brazilian Real",
            "USD": "Dolar"
        ]
        service.isError = true
        sut.fechCurrencys()
        XCTAssertNil(sut.listCurrency.first?.key)
    }
    
    func testAddObservable() {
        service.result = [
            "BRL": "Brazilian Real",
            "USD": "Dolar"
        ]
        sut.fechCurrencys()
        sut.addObservableSearch()
        sut.searchedText.onNext("BRL")
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut.listCurrencyRelay.value.first?.key, "BRL")
    }
    
    func testAddObservableError() {
        service.result = [
            "BRL": "Brazilian Real",
            "USD": "Dolar"
        ]
        sut.fechCurrencys()
        sut.addObservableSearch()
        sut.searchedText.onNext("")
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut.listCurrencyRelay.value, sut.listCurrency)
    }
    
}
