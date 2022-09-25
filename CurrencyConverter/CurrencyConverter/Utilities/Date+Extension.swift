//
//  Date+Extension.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 08/10/20.
//

import Foundation

extension Date {
    static func formatter(timestamp: Int) -> String {
        let unixtimeInterval = Double(timestamp)
        let date = Date(timeIntervalSince1970: unixtimeInterval)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm"
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
}
