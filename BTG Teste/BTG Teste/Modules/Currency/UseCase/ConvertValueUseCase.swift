//
//  ConvertValueUseCase.swift
//  BTG Teste
//
//  Created by Nunes Dreyer, Tiago on 08/12/20.
//  Copyright © 2020 Nunes Dreyer, Tiago. All rights reserved.
//

import Foundation

class ConvertValueUseCase {
    func execute(value: Double, from: Currency, to: Currency, source: String) -> Double {
        if from.symbol == source {
            return value * to.value
        } else if to.symbol == source {
            return value / from.value
        }  else {
            return ( value / from.value ) * to.value
        }
    }
}
