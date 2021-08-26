//
//  ConversionViewControllerTests.swift
//  Desafio_BTGTests
//
//  Created by Kleyson on 15/12/2020.
//  Copyright © 2020 Kleyson. All rights reserved.
//

import XCTest
@testable import Desafio_BTG

final class ConversionViewControllerTests: XCTestCase {
    var sut: ConversionViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = ConversionViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }

    func testPickerViewNumberOfComponents() {
        let pickerView = UIPickerView()
        let numberOfComponents = sut.numberOfComponents(in: pickerView)
        XCTAssertEqual(numberOfComponents, 1)
    }
}
