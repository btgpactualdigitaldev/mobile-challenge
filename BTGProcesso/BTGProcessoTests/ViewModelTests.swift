//
//  ViewModelTests.swift
//  BTGProcessoTests
//
//  Created by Lelio Jorge Junior on 09/12/20.
//

import Foundation


import XCTest
@testable import BTGProcesso


class ViewModelTests: XCTestCase {

    func test_viewModel() {
        let viewModel = QuotaViewModel(dataServiceAPI: QuotaAPI())
        viewModel.fetchCoins()
        viewModel.didFinishFetchCoins = {
            XCTAssertNotNil(viewModel.siglaCoins)
            XCTAssertNotNil(viewModel.nameCoins)
            debugPrint(viewModel.siglaCoins!)
            debugPrint(viewModel.nameCoins!)
        }
        
        viewModel.fetchQuota(with: "EUR")
        viewModel.didFinishFetchQuota = {
            XCTAssertNotNil(viewModel.quota)
            debugPrint(viewModel.quota!)
        }
    }
}
