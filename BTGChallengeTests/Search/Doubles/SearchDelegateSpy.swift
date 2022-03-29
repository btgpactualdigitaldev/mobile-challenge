//
//  SearchDelegateSpy.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import UIKit
@testable import BTGChallenge

class SearchDelegateSpy: SearchDelegate {
    
    var isCurrencieSelectedClickedCalled = false
    func currencieSelectedClicked(_ cell: CurrencyCellView) {
        isCurrencieSelectedClickedCalled = true
    }

}
