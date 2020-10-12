//
//  ChallengeTests.swift
//  ChallengeTests
//
//  Created by Eduardo Raffi on 10/10/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import XCTest
@testable import Challenge

class AvailableCurrencyViewTestCase: XCTestCase {

    var sut: AvailableCurrencyView!
    
    override func setUp() {
        super.setUp()
        sut = AvailableCurrencyView(frame: .zero)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testNumberOfViews() throws {
        var tableCount = 0
        var searchCount = 0
        XCTAssertEqual(sut.subviews.count, 2)
        _ = sut.subviews.map { view in
            if view is UITableView {
                tableCount += 1
            }
            if view is UISearchBar {
                searchCount += 1
            }
        }
        XCTAssertEqual(tableCount, 1)
        XCTAssertEqual(searchCount, 1)
    }

}
