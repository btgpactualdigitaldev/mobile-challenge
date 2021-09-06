//
//  CalculateCurrencyUseCaseSpy.swift
//  CurrienciesTests
//
//  Created by Ferraz on 05/09/21.
//

@testable import Curriencies

final class CalculateCurrencyUseCaseSpy: CalculateCurrencyUseCaseProtocol {
    private var value: Double = 0.0
    
    private(set) var callCalculateCurrency = 0
    private(set) var originCodeReceive = ""
    private(set) var destinationCodeReceive = ""
    
    func setValue(_ value: Double) {
        self.value = value
    }
    
    func calculateCurrency(currencies: [CurrencyEntity], originCode: String, destinationCode: String, originValue: Double) -> Double {
        callCalculateCurrency += 1
        originCodeReceive = originCode
        destinationCodeReceive = destinationCode
        return value
    }
}
