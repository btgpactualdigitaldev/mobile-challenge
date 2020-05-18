//
//  CoinListViewControllerTests.swift
//  BtgChallengeTests
//
//  Created by Felipe Alexander Silva Melo on 17/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import XCTest
@testable import BtgChallenge

class CoinListViewControllerTests: XCTestCase {

    var window: UIWindow!
    var viewController: CoinListViewController!
    
    var repository: CurrencyRepositorySpy!
    var viewModel: CoinListViewModelSpy!
    var coordinator: CoinListCoordinatorSpy!
    var delegate: CoinListViewControllerDelegateSpy! //swiftlint:disable:this weak_delegate
    
    override func setUp() {
        window = UIWindow()
        repository = CurrencyRepositorySpy()
        viewModel = CoinListViewModelSpy()
        coordinator = CoinListCoordinatorSpy()
        delegate = CoinListViewControllerDelegateSpy()
        viewController = CoinListViewController(viewModel: viewModel, coordinator: coordinator, delegate: delegate)
        
        RunLoop.current.run(until: Date())
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func loadView() {
        window.addSubview(viewController.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Spy
    
    class CoinListCoordinatorSpy: CoinListCoordinatorDelegate {
        var closeCalled = false
        
        func close() {
            closeCalled = true
        }
    }
    
    class CoinListViewModelSpy: CoinListViewModelInput {
        var searchForCoinCalled = false
        var viewDidLoadCalled = false
        var searchString = ""
        
        func searchForCoin(string: String) {
            searchString = string
            searchForCoinCalled = true
        }
        
        func viewDidLoad() {
            viewDidLoadCalled = true
        }
    }
    
    class CoinListViewControllerDelegateSpy: CoinListViewControllerDelegate {
        var updateCoinCalled = false
        var viewModel: CoinListCellViewModel?
        
        func updateCoin(viewModel: CoinListCellViewModel) {
            self.viewModel = viewModel
            updateCoinCalled = true
        }
    }
    
    class CoinListTableViewSpy: CoinListTableView {
        var reloadDataCalled = false
        var reloadSectionsCalled = false
        var cellForRowAtCalled = false
        var didSelectRowAtCalled = false
        var numberOfRowsInSectionCalled = false
        
        override func reloadData() {
            reloadDataCalled = true
            super.reloadData()
        }
        
        override func reloadSections(_ sections: IndexSet, with animation: UITableView.RowAnimation) {
            reloadSectionsCalled = true
            super.reloadSections(sections, with: animation)
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            numberOfRowsInSectionCalled = true
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            cellForRowAtCalled = true
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            didSelectRowAtCalled = true
        }
    }

    // MARK: - Tests
    
    func testViewDidLoad() {
        // When
        loadView()
        
        // Then
        XCTAssertNotNil(viewController.coinListView)
        XCTAssertNotNil(viewController.view)
        XCTAssertNotNil(viewController.navigationItem.searchController)
        
        XCTAssertEqual(viewController.coinListView, viewController.view)
        XCTAssertEqual(viewController.title, MockFactory.coinListTitle)
        
        XCTAssertTrue(viewModel.viewDidLoadCalled)
    }
    
    func testUpdateSearchResults() {
        // Given
        let string = "USD"
        viewController.searchController.searchBar.text = string
        
        // When
        loadView()
        viewController.updateSearchResults(for: viewController.searchController)
        
        // Then
        XCTAssertTrue(viewModel.searchForCoinCalled)
        XCTAssertEqual(viewModel.searchString, string)
    }
    
    func testDisplayCoinList() {
        // Given
        loadView()
        let viewModel = MockFactory.createListTableViewModel()
        let tableView = CoinListTableViewSpy(delegate: viewController)
        viewController.coinListView?.coinListTableView = tableView
        
        // When
        viewController.displayCoinList(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(tableView.viewModel.cellViewModels.count, viewModel.cellViewModels.count)
        
        XCTAssertFalse(tableView.firstUpdate)
        XCTAssertFalse(tableView.reloadDataCalled)
        
        XCTAssertTrue(tableView.reloadSectionsCalled)
        XCTAssertTrue(tableView.numberOfRowsInSectionCalled)
        XCTAssertTrue(tableView.cellForRowAtCalled)
    }
    
    func testDidSelectRow() {
        // Given
        let viewModel = MockFactory.createCellViewModel()
        
        // When
        viewController.didSelectRow(viewModelSelected: viewModel)
        
        // Then
        XCTAssertTrue(coordinator.closeCalled)
        XCTAssertTrue(delegate.updateCoinCalled)
        
        XCTAssertEqual(delegate.viewModel?.fullCoinName, viewModel.fullCoinName)
        XCTAssertEqual(delegate.viewModel?.shortCoinName, viewModel.shortCoinName)
    }

}
