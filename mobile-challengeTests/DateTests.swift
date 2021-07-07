//
//  DateTests.swift
//  mobile-challengeTests
//
//  Created by Murilo Teixeira on 27/09/20.
//

import XCTest

class DateTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testStringDateIsNotNil() {
        let date = Date()
        XCTAssertNotNil(date.string)
    }
    
    func testDateStringisValid() {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(year: 2020, month: 9, day: 27, hour: 16)
        let date = calendar.date(from: components)
        let expected = "27/09/2020 16:00:00"
        let dateString = date?.string
        XCTAssertEqual(expected, dateString)
    }

}
