//
//  ExchangeScreenButtonsUITests.swift
//  EasyMoneyExchangerUITests
//
//  Created by Leon on 14/12/20.
//

import XCTest

class ExchangeAppUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUp() {
        super.setUp()

        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
        app = nil
    }

    func testFromButton() throws {
        app.tables["00,00, Currency Name, 2020-12-14 08:58, Amount, From, To"].buttons["🏳️ Afghan Afghani"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Cancel"]/*[[".buttons[\"Cancel\"].staticTexts[\"Cancel\"]",".staticTexts[\"Cancel\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }

    func testToButton() throws {
        app.tables["00,00, Currency Name, 2020-12-14 08:58, Amount, From, To"].buttons["🇧🇷 Brazilian Real"].tap()
        app.buttons["Cancel"].tap()
    }

    func testGoToSearchScreen() throws {
        app.tables["00,00, Currency Name, 2020-12-14 08:58, Amount, From, To"].buttons["List"].tap()
        app.buttons["Back"].tap()
    }

    func testSwitchCurrencies() throws {
        app.tables["00,00, Currency Name, 2020-12-14 08:58, Amount, From, To"].buttons["repeat 1"].tap()
    }

    func testUpdateCurrencies() throws {
        app.tables["00,00, Currency Name, 2020-12-14 08:58, Amount, From, To"].buttons["go forward"].tap()
    }
}
