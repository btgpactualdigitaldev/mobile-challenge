//
//  mobile_challengeTests.swift
//  mobile-challengeTests
//
//  Created by Alan Silva on 10/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import XCTest
@testable import mobile_challenge

class mobile_challengeTests: XCTestCase {
    
    let controller = CurrencyController()
    var sut : CurrencyListViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExchangeCalculation() {
        
        let amount = 20.0
        let value1 = 5.50
        let value2 = 2.98
        
        let result = (amount / value1) * value2
        
        let calc = controller.calculate(amount: amount, value1: value1, value2: value2)
        
        XCTAssertEqual(result, calc)
        
    }
    
    func testCheckAPICall(){
        
        let dataProvider = CurrencyDataProvider()
        
        let expec = expectation(description: "Running the callback closure in order to get the List of all currencies from the API")
        dataProvider.getListOfCurrencies { (results) in
            
            XCTAssertNotNil(results)
            
            expec.fulfill()
            
        }
        
        waitForExpectations(timeout: 10) { (error ) in
            
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            
        }
        
    }

    /*func testCheck(){

        let amount = 20.0
        let from = "BRL"
        let to = "AFN"

        let expec = expectation(description: "Testing getCurrencyList ")

        controller.setupCurrencyListViewController()
        controller.getCurrencyExchange(closure: { (conversion) in

            //XCTAssertEqual(conversion, 20.0)
            XCTAssertNotNil(conversion)
            
            expec.fulfill()


        }, amount: amount, from: from, to: to)

        waitForExpectations(timeout: 10) { (error ) in

            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }

        }

    }*/
    
}

