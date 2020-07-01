//
//  DateTests.swift
//  Coin ConverterTests
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
//

@testable import Coin_Converter
import XCTest

class DateTests: XCTestCase {

    func testDateFormatted() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let date: Date = dateFormatter.date(from: "2020-06-29 16:37:05")!
        
        let expectedDate: String = "29/06/2020 16:37"
        XCTAssertEqual(expectedDate, date.dateFormatted)
    }
    
    func testTimestampToDate() {
        let date: Date = Date.timestampToDate(timestamp: 1593448625)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let expectedDate: Date = dateFormatter.date(from: "2020-06-29 16:37:05")!
        XCTAssertEqual(expectedDate, date)
    }

}
