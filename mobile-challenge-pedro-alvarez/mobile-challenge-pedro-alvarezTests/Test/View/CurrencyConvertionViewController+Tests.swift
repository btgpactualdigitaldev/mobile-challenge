//
//  CurrencyConvertionViewController+Tests.swift
//  mobile-challenge-pedro-alvarezTests
//
//  Created by Pedro Alvarez on 28/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//

@testable import mobile_challenge_pedro_alvarez
import XCTest

class CurrencyConvertionViewController_Tests: XCTestCase {

    var sut: CurrencyConversionViewController!
    
    override func setUp() {
        sut = CurrencyConversionViewController()
    }
    
    override func tearDown() {
        sut = nil
    }
}
