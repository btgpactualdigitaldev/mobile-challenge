//
//  SearchViewControllerTestCase.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 29/03/22.
//

import XCTest
import RxSwift
import RxTest
@testable import BTGChallenge

class SearchViewControllerTestCase: XCTestCase {
    
    var sut: SearchViewController!
    var viewModel: SearchViewModel!
    var service: SearchServiceStub!
    
    override func setUp() {
        super.setUp()
        service = SearchServiceStub()
        viewModel = SearchViewModel(service: service)
        sut = SearchViewController(viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        service = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testBegin() {
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
        XCTAssertTrue(sut.view is SearchView)
    }

}
