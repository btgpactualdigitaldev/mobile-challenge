//
//  QuotationColors.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 26/11/20.
//

import UIKit

enum QuotationColors {
    case convertButton
    case currencyButton
    case buttonTextColor
    case errorLabel
    case resultLabel
    case textFiledBackground
    case topBackground
    
    var color: UIColor? {
        switch self {
        case .convertButton:
            return UIColor(named: "ConvertButton")
        case .currencyButton:
            return UIColor(named: "CurrencyButton")
        case .buttonTextColor:
            return UIColor(named: "ButtonTextColor")
        case .errorLabel:
            return UIColor(named: "ErrorLabel")
        case .resultLabel:
            return UIColor(named: "ResultLabel")
        case .textFiledBackground:
            return UIColor(named: "TextFieldBackground")
        case .topBackground:
            return UIColor(named: "TopBackground")
        }
    }
}
