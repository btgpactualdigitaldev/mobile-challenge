//
//  appStrings.swift
//  BTGMobileChallenge
//
//  Created by Carlos Roberto Modinez Junior on 06/08/21.
//

import Foundation

class AppStrings {
	
	static let shared = AppStrings()
	
	var fromCurrencCellTitle: String { return getString(forKey: "fromCurrencCellTitle") }
	var toCurrencCellTitle: String { return getString(forKey: "toCurrencCellTitle") }
	var clickToChoiceTip: String { return getString(forKey: "clickToChoiceTip") }
	var choiceCurrencySearchPlaceholder: String { return getString(forKey: "choiceCurrencySearchPlaceholder") }
	
	var generalPopupErrorDescription: String { return getString(forKey: "generalPopupErrorDescription")}
	var internetPopupErrorDescription: String { return getString(forKey: "internetPopupErrorDescription")}
	var convertionFailedPopupErrorDescription: String { return getString(forKey: "convertionFailedPopupErrorDescription")}
	var popupErrorTitle: String { return getString(forKey: "popupErrorTitle")}
	
	private func getString(forKey key: String) -> String {
		return Bundle.main.localizedString(forKey: key, value: nil, table: "AppStrings")
	}
}
