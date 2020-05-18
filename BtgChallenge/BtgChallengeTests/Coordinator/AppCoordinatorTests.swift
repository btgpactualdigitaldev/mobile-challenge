//
//  AppCoordinatorTests.swift
//  BtgChallengeTests
//
//  Created by Felipe Alexander Silva Melo on 17/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import XCTest
@testable import BtgChallenge

class AppCoordinatorTests: XCTestCase {

    var window: UIWindow!
    var coordinator: AppCoordinator!
    var navigationController: NavigationControllerSpy!
    
    override func setUp() {
        window = UIWindow()
        coordinator = AppCoordinator(window: window)
        coordinator.start()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: - Spy
    
    class NavigationControllerSpy: UINavigationController {
        var pushViewControllerCalled = false
        var popViewControllerCalled = false
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushViewControllerCalled = true
            super.pushViewController(viewController, animated: false)
        }
        
        override func popViewController(animated: Bool) -> UIViewController? {
            popViewControllerCalled = true
            return super.popViewController(animated: false)
        }
    }
    
    // MARK: - Tests

    func testStart() {
        XCTAssertNotNil(coordinator.navigationController)
        XCTAssertNotNil(coordinator.window.rootViewController)
        XCTAssertEqual(coordinator.window.backgroundColor, .darkBlue)
        XCTAssertEqual(coordinator.navigationController.viewControllers.count, 1)
        XCTAssertNotNil(coordinator.navigationController.topViewController as? CoinConvertViewController)
    }
    
    func testShowCoinList() {
        // Given
        navigationController = NavigationControllerSpy()
        coordinator.navigationController = navigationController
        
        // When
        coordinator.showCoinList(delegate: nil)
        
        // Then
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.pushViewControllerCalled)
        XCTAssertNotNil(coordinator.navigationController.topViewController as? CoinListViewController)
    }

    func testClose() {
        // Given
        navigationController = NavigationControllerSpy()
        coordinator.navigationController = navigationController
        
        // When
        coordinator.close()
        
        // Then
        XCTAssertTrue(navigationController.popViewControllerCalled)
    }

}
