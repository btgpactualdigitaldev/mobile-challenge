//
//  CalculateCurrencyUseCase.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

protocol CalculateCurrencyUseCaseProtocol {
    func calculateCurrency(currencies: [CurrencyEntity],
                           originCode: String,
                           destinationCode: String,
                           originValue: Double) -> Double
}

struct CalculateCurrencyUseCase: CalculateCurrencyUseCaseProtocol {
    func calculateCurrency(currencies: [CurrencyEntity],
                           originCode: String,
                           destinationCode: String,
                           originValue: Double) -> Double {
        var originValuePositive = originValue
        if originValue < 0 {
            originValuePositive *= -1
        }
        let originEntity = currencies.first {
            $0.code == originCode
        }
        let destinationEntity = currencies.first {
            $0.code == destinationCode
        }
        let originValueDollar = originValuePositive / (originEntity?.value ?? 1)
        let destinationValue = originValueDollar * (destinationEntity?.value ?? 1)
        
        return destinationValue
    }
}
