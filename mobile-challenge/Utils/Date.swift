//
//  Date.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

public extension Date {
    var string: String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.locale = Locale.current
        formatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        return formatter.string(from: self)
    }
}
