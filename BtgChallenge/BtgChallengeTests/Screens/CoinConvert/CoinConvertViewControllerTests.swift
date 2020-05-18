//
//  CoinConvertViewControllerTests.swift
//  BtgChallengeTests
//
//  Created by Felipe Alexander Silva Melo on 17/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import XCTest
@testable import BtgChallenge

class CoinConvertViewControllerTests: XCTestCase {

    var window: UIWindow!
    var coinConvertViewController: CoinConvertViewController!
    
    var repository: CurrencyRepositorySpy!
    var viewModel: CoinConvertViewModelSpy!
    var coordinator: CoinConvertCoordinatorSpy!
    
    override func setUp() {
        window = UIWindow()
        repository = CurrencyRepositorySpy()
        viewModel = CoinConvertViewModelSpy()
        coordinator = CoinConvertCoordinatorSpy()
        coinConvertViewController = CoinConvertViewController(viewModel: viewModel, coordinator: coordinator)
        
        RunLoop.current.run(until: Date())
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    func loadView() {
        window.addSubview(coinConvertViewController.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Spy
    
    class CoinConvertViewSpy: CoinConvertView {
        var endEditingCalled = false
        var forceEditing = false
            
        override func endEditing(_ force: Bool) -> Bool {
            endEditingCalled = true
            forceEditing = force
            return super.endEditing(force)
        }
    }
    
    class CoinConvertCoordinatorSpy: CoinConvertCoordinatorDelegate {
        var showCoinListCalled = false
        weak var delegate: CoinListViewControllerDelegate?
        
        func showCoinList(delegate: CoinListViewControllerDelegate?) {
            self.delegate = delegate
            showCoinListCalled = true
        }
    }
    
    class CoinConvertViewModelSpy: CoinConvertViewModelDataStore, CoinConvertViewModelInput {
        var fromCoinNickname: String = ""
        var fromCoinValue: String = ""
        var toCoinNickname: String = ""
        var selectedCoinType: CoinType?
        
        var getConversionQuoteCalled = false
        var updateFromCoinValueCalled = false
        var updateSelectedCoinTypeCalled = false
        var updateCoinNicknameCalled = false
        var viewDidLoadCalled = false
        
        func viewDidLoad() {
            viewDidLoadCalled = true
        }
        
        func getConversionQuote() {
            getConversionQuoteCalled = true
        }
        
        func updateFromCoinValue(value: String) {
            fromCoinValue = value
            updateFromCoinValueCalled = true
        }
        
        func updateSelectedCoinType(type: CoinType) {
            selectedCoinType = type
            updateSelectedCoinTypeCalled = true
        }
        
        func updateCoinNickname(nickname: String) {
            if selectedCoinType == .to {
                toCoinNickname = nickname
            } else {
                fromCoinNickname = nickname
            }
            
            updateCoinNicknameCalled = true
        }
    }

    // MARK: - Tests
    
    func testViewDidLoad() {
        // When
        loadView()
        
        // Then
        XCTAssertNotNil(coinConvertViewController.coinConvertView)
        XCTAssertNotNil(coinConvertViewController.view)
        
        XCTAssertEqual(coinConvertViewController.coinConvertView, coinConvertViewController.view)
        XCTAssertEqual(coinConvertViewController.title, MockFactory.coinConvertTitle)
        
        XCTAssertTrue(viewModel.viewDidLoadCalled)
    }
    
    func testTouchesBegan() {
        // Given
        let coinConvetView = CoinConvertViewSpy(viewController: coinConvertViewController)
        coinConvertViewController.view = coinConvetView
        
        // When
        loadView()
        coinConvertViewController.touchesBegan(Set<UITouch>(), with: nil)
        
        // Then
        XCTAssertTrue(coinConvetView.endEditingCalled)
        XCTAssertTrue(coinConvetView.forceEditing)
    }
    
    func testDisplayFromCoinNickname() {
        // When
        loadView()
        coinConvertViewController.displayFromCoinNickname(coinNickname: MockFactory.dollarNickname)
        
        // Then
        XCTAssertEqual(
            coinConvertViewController.coinConvertView?.fromCoinView.coinButton.coinTypeLabel.text,
            MockFactory.dollarNickname
        )
    }
    
    func testDisplayToCoinNickname() {
        // When
        loadView()
        coinConvertViewController.displayToCoinNickname(coinNickname: MockFactory.dollarNickname)
        
        // Then
        XCTAssertEqual(
            coinConvertViewController.coinConvertView?.toCoinView.coinButton.coinTypeLabel.text,
            MockFactory.dollarNickname
        )
    }
    
    func testDisplayConversionValue() {
        // When
        loadView()
        coinConvertViewController.displayConversionValue(conversionValue: MockFactory.coinValue)
        
        // Then
        XCTAssertEqual(
            coinConvertViewController.coinConvertView?.toCoinView.valueTextField.text,
            MockFactory.coinValue
        )
    }
    
    func testDidTapButton() {
        // When
        coinConvertViewController.didTapButton(view: BtgButton())
        
        // Then
        XCTAssertTrue(viewModel.getConversionQuoteCalled)
    }
    
    func testDidUpdateCurrency() {
        // When
        coinConvertViewController.didUpdateCurrency(
            view: CoinView(coinType: MockFactory.coinType),
            value: MockFactory.coinValue
        )
        
        // Then
        XCTAssertTrue(viewModel.updateFromCoinValueCalled)
        XCTAssertEqual(viewModel.fromCoinValue, MockFactory.coinValue)
    }
    
    func testDidTapCoinButton() {
        // When
        coinConvertViewController.didTapCoinButton(view: CoinView(coinType: MockFactory.coinType))
        
        // Then
        XCTAssertTrue(viewModel.updateSelectedCoinTypeCalled)
        XCTAssertTrue(coordinator.showCoinListCalled)
        
        XCTAssertEqual(viewModel.selectedCoinType, MockFactory.coinType)
        
        XCTAssertNotNil(coordinator.delegate)
    }
    
    func testUpdateCoin_WithTypeTo() {
        // Given
        let cellViewModel = MockFactory.createCellViewModel()
        viewModel.selectedCoinType = .to
        
        // When
        coinConvertViewController.updateCoin(viewModel: cellViewModel)
        
        // Then
        XCTAssertTrue(viewModel.updateCoinNicknameCalled)
        XCTAssertEqual(viewModel.toCoinNickname, cellViewModel.shortCoinName)
    }
    
    func testUpdateCoin_WithTypeFrom() {
        // Given
        let cellViewModel = MockFactory.createCellViewModel()
        viewModel.selectedCoinType = .from
        
        // When
        coinConvertViewController.updateCoin(viewModel: cellViewModel)
        
        // Then
        XCTAssertTrue(viewModel.updateCoinNicknameCalled)
        XCTAssertEqual(viewModel.fromCoinNickname, cellViewModel.shortCoinName)
    }

}
