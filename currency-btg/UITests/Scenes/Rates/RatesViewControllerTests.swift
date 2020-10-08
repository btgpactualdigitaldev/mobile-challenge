import XCTest
import UIKit
import Presenter
@testable import UI

class RatesViewControllerTests: XCTestCase {

    func test_loading_is_hidden_on_start() throws {
        XCTAssertEqual(makeSut().loadingIndicator?.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() throws {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() throws {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_sut_calls_listQuotes() throws {
        var callsCount = 0
        let _ = makeSut(listQuotesSpy: {
            callsCount += 1
        })
        XCTAssertEqual(callsCount, 1)
    }
}

extension RatesViewControllerTests {
    func makeSut(listQuotesSpy: (() -> Void)? = nil) -> RatesViewController {
        let sut = RatesViewController.instantiate()
        sut.listQuotes = listQuotesSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
