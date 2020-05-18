//
//  CoinListViewModelTests.swift
//  BtgChallengeTests
//
//  Created by Felipe Alexander Silva Melo on 18/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import XCTest
@testable import BtgChallenge

class CoinListViewModelTests: XCTestCase {

    var viewModel: CoinListViewModel!
    var repository: CurrencyRepositorySpy!
    var viewController: ViewModelOutputSpy!
    
    override func setUp() {
        setup(withSuccessRepository: true)
    }
    
    func setup(withSuccessRepository isSuccess: Bool) {
        repository = CurrencyRepositorySpy(isSuccess: isSuccess)
        viewModel = CoinListViewModel(repository: repository)
        
        viewController = ViewModelOutputSpy()
        viewModel.viewController = viewController
    }

    // MARK: - Spy
    
    class ViewModelOutputSpy: CoinListViewModelOutput {
        var displayCoinListCalled = false
        var displayListErrorCalled = false
        
        var viewModel: CoinListTableViewModel?
        var message = ""
        
        func displayCoinList(viewModel: CoinListTableViewModel) {
            self.viewModel = viewModel
            displayCoinListCalled = true
        }
        
        func displayListError(message: String) {
            self.message = message
            displayListErrorCalled = true
        }
    }
    
    // MARK: - Tests

    func testViewDidLoad() {
        // Given
        let listResponse = MockFactory.createListResponse()
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewController.displayCoinListCalled)
        XCTAssertEqual(viewController.viewModel?.cellViewModels.first?.fullCoinName, listResponse.currencies?.EUR)
    }
    
    func testViewDidLoad_WithFail() {
        // Given
        setup(withSuccessRepository: false)
        
        // When
        viewModel.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewController.displayListErrorCalled)
        XCTAssertEqual(viewController.message, Constants.Errors.apiDefaultMessage)
    }

    func testSearchForCoin() {
        // Given
        let string = "USD"
        
        // When
        viewModel.viewDidLoad()
        viewModel.searchForCoin(string: string)
        
        // Then
        XCTAssertTrue(viewController.displayCoinListCalled)
        XCTAssertEqual(viewController.viewModel?.cellViewModels.count, 1)
        XCTAssertEqual(viewController.viewModel?.cellViewModels.first?.fullCoinName, string)
    }

}
