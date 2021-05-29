//
//  QuotationViewControllerTests.swift
//  mobile-challengeTests
//
//  Created by Caio Azevedo on 28/11/20.
//

import XCTest
@testable import mobile_challenge

class QuotationViewControllerTests: XCTestCase {
    
    var viewModel: QuotationViewModel!
    var sut: QuotationViewController!

    override func setUp() {
        viewModel = QuotationViewModel()
        sut = QuotationViewController(viewModel: viewModel)
    }

    override func tearDown() {
        sut = nil
        viewModel = nil
    }
    
    func test_convertText() {
        let string = "0"
        let range = NSRange(location: 5, length: 0)
        let text = "20.00"
        
        let result = sut.convertText(string: string, range: range, text: text)
        
        XCTAssertEqual(result, "200.00")
    }

}
