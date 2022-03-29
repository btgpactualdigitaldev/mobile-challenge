//
//  ConversionViewModelTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
import RxSwift
import RxTest
@testable import BTGChallenge

class ConversionViewModelTestCase: XCTestCase {
    
    var sut: ConversionViewModel!
    var userDefaultFake: UserDefaultFake!
    var service: ConversionServiceStub!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        service = ConversionServiceStub()
        userDefaultFake = UserDefaultFake()
        sut = ConversionViewModel(acronym: String(), service: service, userDefault: userDefaultFake)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        super.tearDown()
    }
    
    func testFetchQuotes() {
        service.result = ["BRL":5.89]
        sut.fetchQuotes()
        XCTAssertEqual(sut.quotes.first?.key, "BRL")
    }
    
    func testFetchQuotesError() {
        service.result = ["BRL":5.89]
        service.isError = true
        sut.fetchQuotes()
        XCTAssertNotEqual(sut.quotes.first?.key, "BRL")
    }
    
    func testFormatValue() {
        let result = sut.formatValue(123.45454545)
        XCTAssertEqual(result, 123.455)
    }
    
    func testConvertUsdToBRL() {
        userDefaultFake.set("USD", forKey: "valueOne")
        userDefaultFake.set("BRL", forKey: "valueTwo")
        service.result = [
            "USDBRL":2.0,
            "USDEUR":3.0
        ]
        sut.fetchQuotes()
        let viewFake = ConversionView(viewModel: sut)
        sut.convert("3,45")
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewFake.inputValueResul.text, "6.9")
    }
    
    func testConvertBrlToUsd() {
        userDefaultFake.set("BRL", forKey: "valueOne")
        userDefaultFake.set("USD", forKey: "valueTwo")
        service.result = [
            "USDBRL":2.0,
            "USDEUR":3.0
        ]
        sut.fetchQuotes()
        let viewFake = ConversionView(viewModel: sut)
        sut.convert("3,45")
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewFake.inputValueResul.text, "1.725")
    }
    
    func testConvertBrlToEur() {
        userDefaultFake.set("BRL", forKey: "valueOne")
        userDefaultFake.set("EUR", forKey: "valueTwo")
        service.result = [
            "USDBRL":2.0,
            "USDEUR":3.0
        ]
        sut.fetchQuotes()
        let viewFake = ConversionView(viewModel: sut)
        sut.convert("3,45")
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewFake.inputValueResul.text, "5.175")
    }
    
    func testConvertUsdToUsd() {
        userDefaultFake.set("USD", forKey: "valueOne")
        userDefaultFake.set("USD", forKey: "valueTwo")
        service.result = [
            "USDBRL":2.0,
            "USDEUR":3.0
        ]
        sut.fetchQuotes()
        let viewFake = ConversionView(viewModel: sut)
        sut.convert("3,45")
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewFake.inputValueResul.text, "3.45")
    }
    
    func testGetNumber() {
        let result = sut.getNumber("3,45")
        XCTAssertEqual(result, 3.45)
    }
    
}
