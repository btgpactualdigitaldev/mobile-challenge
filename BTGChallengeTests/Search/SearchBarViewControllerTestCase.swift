//
//  SearchBarViewControllerTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import XCTest
import RxSwift
import RxTest
import iOSSnapshotTestCase
@testable import BTGChallenge

class SearchBarViewControllerTestCase: FBSnapshotTestCase {
    
    var sut: SearchBarViewController!
    var delegateSpy: SearchBarDelegateSpy!
    
    override func setUp() {
        super.setUp()
        delegateSpy = SearchBarDelegateSpy()
        sut = SearchBarViewController(buttonScopes: [], delegateSpy)
        sut.view.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
        recordMode = false
    }
    
    override func tearDown() {
        sut = nil
        delegateSpy = nil
        super.tearDown()
    }

    func testSnapshot() {
        FBSnapshotVerifyViewController(sut)
        FBSnapshotVerifyLayer(sut.view.layer)
    }

    func testDelegateSearchController() {
        sut.updateSearchResults(for: sut)
        XCTAssertTrue(delegateSpy.isSearchBarControllerIsCalled)
    }
    
    func testDelegateSearchControllerSearchBarMethod() {
        sut.searchBar(sut.searchBar, selectedScopeButtonIndexDidChange: 0)
        XCTAssertTrue(delegateSpy.isSearchBarIsCalled)
    }
    
}
