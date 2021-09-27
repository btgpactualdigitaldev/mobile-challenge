//
//  Constants.swift
//  Mobile Challenge
//
//  Created by Daive Costa Nardi Simões on 24/09/21.
//

enum Constants: String {
    case serverURL = "ServerURL"
    
    case ConverterNotificationName = "Notification.ConvertedValue"
    case ConversionErrorNotificationName = "Notification.ConversionError"
    
    case CurrencyListNotificationName = "Notification.CurrencyList"
    case CurrencyListErrorNotificationName = "Notification.ListCurrencyError"
    
    case currenciesDTOKey = "com.simoes.daive.Mobile-Challenge.currenciesDTO"
    case dollarQuoteDTOKey = "com.simoes.daive.Mobile-Challenge.currentDollarQuoteDTO"
    
    case converterScreenTitle = "Conversor"
    case currencyListScreenTitle = "Moedas"
    
    case converterStoryboardName = "Converter"
    case currencyListStoryboardName = "CurrencyList"
}
