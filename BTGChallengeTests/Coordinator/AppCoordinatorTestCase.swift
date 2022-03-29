//
//  AppCoordinatorTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
@testable import BTGChallenge

class AppCoordinatorTestCase: XCTestCase {
    
    var sut: AppCoordinator!
    var navigationSpy: UINavigationControllerSpy!

    override func setUp() {
        super.setUp()
        navigationSpy = UINavigationControllerSpy()
        sut = AppCoordinator(window: UIWindow(), navigationController: navigationSpy)
    }
    
    override func tearDown() {
        sut = nil
        navigationSpy = nil
        super.tearDown()
    }

    func testStart() {
        sut.start()
        XCTAssertNotEqual(navigationSpy, sut.navigationController)
    }
    
    func testCallEventHome() {
        sut.callEvent(event: AppCoordinatorDestinys.home)
        XCTAssertTrue(navigationSpy.popToRootCalled)
    }
    
    func testCallEventConversion() {
        sut.callEvent(event: AppCoordinatorDestinys.conversion)
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
    
    func testCallEventSearch() {
        sut.callEvent(event: AppCoordinatorDestinys.search)
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
    
    func testCallEventConvertionWithAcronym() {
        sut.callEvent(event: AppCoordinatorDestinys.conversionWithAcronym(acronym: "USD"))
        XCTAssertEqual(sut.childCoordinators.count, 1)
    }
    
    func testRemoveElement() {
        let coordinator = ConversionCoordinator()
        sut.childCoordinators.append(coordinator)
        sut.callEvent(event: AppCoordinatorDestinys.removeItem(coordinator: coordinator))
        XCTAssertTrue(sut.childCoordinators.isEmpty)
    }
    
}
