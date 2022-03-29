//
//  SearchCoordinatorTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
@testable import BTGChallenge

class SearchCoordinatorTestCase: XCTestCase {
    
    var sut: SearchCoordinator!
    var navigationSpy: UINavigationControllerSpy!

    override func setUp() {
        super.setUp()
        navigationSpy = UINavigationControllerSpy()
        sut = SearchCoordinator()
    }
    
    override func tearDown() {
        sut = nil
        navigationSpy = nil
        super.tearDown()
    }

    func testStart() {
        sut.start(navigation: navigationSpy)
        XCTAssertTrue(navigationSpy.pushViewControllerCalled)
    }

    func testCallEventSearch() {
        sut.navigationController = navigationSpy
        sut.callEvent(event: SearchCoordinatorDestinys.back)
        XCTAssertTrue(navigationSpy.popToRootCalled)
    }
    
    func testCallEventBack() {
        sut.navigationController = navigationSpy
        sut.callEvent(event: SearchCoordinatorDestinys.backToConversion(acronym: "BRL"))
        XCTAssertTrue(navigationSpy.popToRootCalled)
    }
    
}
