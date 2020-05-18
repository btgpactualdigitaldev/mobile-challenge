//
//  Constants.swift
//  BtgChallengeTests
//
//  Created by Felipe Alexander Silva Melo on 17/05/20.
//  Copyright © 2020 Felipe Alexander Silva Melo. All rights reserved.
//

import Foundation
@testable import BtgChallenge

enum TestError: Error {
    case mockError
}

struct MockFactory {
    static let coinConvertTitle = "Convert"
    static let coinListTitle = "Select Coin"
    static let dollarNickname = "USD"
    static let coinValue = "20.00"
    static let coinType = CoinType.to
    
    static func createLiveResponse() -> LiveResponse {
        let liveResponse = LiveResponse()
        liveResponse.quotes = ["USDBRL": 2.5]
        
        return liveResponse
    }
    
    static func createListResponse() -> ListResponse {
        var listResponse = ListResponse()
        let currencies = CurrenciesResponse()
        currencies.USD = "USD"
        currencies.EUR = "EUR"
        listResponse.currencies = currencies

        return listResponse
    }
    
    static func createCellViewModel() -> CoinListCellViewModel {
        let cellViewModel = CoinListCellViewModel()
        cellViewModel.shortCoinName = "USD"
        cellViewModel.fullCoinName = "American Dollar"
        
        return cellViewModel
    }
    
    static func createListTableViewModel() -> CoinListTableViewModel {
        let viewModel = CoinListTableViewModel()
        viewModel.selectedCoin = "USD"
        viewModel.cellViewModels = [createCellViewModel()]
        
        return viewModel
    }
    
    static func createError() -> Error {
        return TestError.mockError
    }
}
