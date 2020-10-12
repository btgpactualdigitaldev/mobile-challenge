//
//  AmountConversionViewControllerTestCase.swift
//  ChallengeTests
//
//  Created by Eduardo Raffi on 11/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import XCTest
@testable import Challenge

class AmountConversionViewControllerTestCase: XCTestCase {
    var sut: AmountConversionViewController!
    
    override func setUp() {
        super.setUp()
        sut = AmountConversionViewController()
        sut.conversionValues = ["USABRL": 3.0]
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testViewController() {
        if let view = sut.view as? ConversionView {
            view.targetMoneyButton.setTitle("BRL", for: .normal)
            view.amountTextField.text = "200.00"
            view.submitButton.sendActions(for: .touchUpInside)
            guard let typedValue = Double(String(view.amountTextField.text!)) else {
                return XCTFail("Invalid double amount")
            }
            view.convertedAmount.text = sut.calculateAmount(typedValue)
            XCTAssertEqual(view.convertedAmount.text, "1 USD = 0.00 BRL\nTotal is: 0.00 BRL")
        }
    }
}
