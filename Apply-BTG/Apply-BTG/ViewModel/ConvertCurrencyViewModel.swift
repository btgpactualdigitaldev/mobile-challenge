//
//  ConvertCurrencyViewModel.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 23/05/21.
//

import Foundation

struct ConvertCurrencyViewModel {
    func formatCurrencyValue(_ value: Double, withCode code: String) -> String {                
        return "\(code) \(String(format: "%.5f", value).replacingOccurrences(of: ".", with: ","))"
    }
}
