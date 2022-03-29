//
//  ConversionDelegateSpy.swift
//  BTGChallengeTests
//
//  Created by Mateus Rodrigues on 28/03/22.
//

import UIKit
@testable import BTGChallenge

class ConversionDelegateSpy: ConversionDelegate {
    
    var buttonConvertClickedValue = String()
    var buttonChoiceCurrencyOneCalled = false
    var buttonChoiceCurrencyTwoCalled = false
    
    func buttonConvertClicked(valueToConvert: String) {
        buttonConvertClickedValue = valueToConvert
    }
    
    func buttonChoiceCurrencyOneClicked() {
        buttonChoiceCurrencyOneCalled = true
    }
    
    func buttonChoiceCurrencyTwoClicked() {
        buttonChoiceCurrencyTwoCalled = true
    }
    
}
