//
//  ConversionViewControllerTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
import RxSwift
import RxTest
@testable import BTGChallenge

class ConversionViewControllerTestCase: XCTestCase {
    
    var sut: ConversionViewController!
    var viewModel: ConversionViewModel!
    var userDefaultFake: UserDefaultFake!
    var service: ConversionServiceStub!
    
    override func setUp() {
        super.setUp()
        service = ConversionServiceStub()
        userDefaultFake = UserDefaultFake()
        viewModel = ConversionViewModel(acronym: String(), service: service, userDefault: userDefaultFake)
        sut = ConversionViewController(viewModel: viewModel, userDefault: userDefaultFake)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        viewModel = nil
        userDefaultFake = nil
        super.tearDown()
    }
    
    func testBegin() {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(sut.view is ConversionView)
    }

    func testButtonConvertClicked() {
        service.result = [
            "USDBRL":2.0,
            "USDEUR":3.0
        ]
        sut.viewModel.fetchQuotes()
        userDefaultFake.set("BRL", forKey: "valueOne")
        userDefaultFake.set("EUR", forKey: "valueTwo")
        sut.buttonConvertClicked(valueToConvert: "3,45")
        let expectation = self.expectation(description: #function)

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            expectation.fulfill()
        })

        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(sut.theView.inputValueResul.text, "5.175")
    }
    
    func testButtonChoiceCurrencyOneClicked() {
        sut.buttonChoiceCurrencyOneClicked()
        XCTAssertEqual(userDefaultFake.setBoolIsCalled, true)
    }
    
    func testButtonChoiceCurrencyTwoClicked() {
        sut.buttonChoiceCurrencyTwoClicked()
        XCTAssertEqual(userDefaultFake.setBoolIsCalled, true)
    }
    
}
