//
//  ConversionCoordinatorTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
@testable import BTGChallenge

class ConversionCoordinatorTestCase: XCTestCase {
    
    var sut: ConversionCoordinator!
    var navigationSpy: UINavigationControllerSpy!

    override func setUp() {
        super.setUp()
        navigationSpy = UINavigationControllerSpy()
        sut = ConversionCoordinator()
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
    
    func testStartWithData() {
        sut.start(data: "BRL", navigation: navigationSpy)
        XCTAssertTrue(navigationSpy.pushViewControllerCalled)
    }
    
    func testCallEventSearch() {
        sut.navigationController = navigationSpy
        sut.callEvent(event: ConversionCoordinatorDestinys.search)
        XCTAssertTrue(navigationSpy.popToRootCalled)
    }
    
    func testCallEventBack() {
        sut.navigationController = navigationSpy
        sut.callEvent(event: ConversionCoordinatorDestinys.back)
        XCTAssertTrue(navigationSpy.popToRootCalled)
    }
    
}
