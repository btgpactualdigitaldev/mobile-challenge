//
//  String+Extensions.swift
//  CurrencyConverter
//
//  Created by Renan Santiago on 14/08/20.
//  Copyright © 2020 Renan Santiago. All rights reserved.
//

import Foundation

extension String {
    // Método simples para garantir que o valor digitado possa ser convertido para Double
    func tryFormattingToCalculation() -> String {
        let text = self.replacingOccurrences(of: ",", with: ".")
        
        if let _ = Double(text) {
            return self
        } else {
            return String(self.dropLast())
        }
    }
}
