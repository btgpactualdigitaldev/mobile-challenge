//
//  Date.swift
//  Coin Converter
//
//  Created by Andre Casarini on 18/08/20.
//  Copyright © 2020 Andre Casarini. All rights reserved.
//

import Foundation

extension Date {
    
    var dateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        return dateFormatter.string(from: self)
    }
    
    static func timestampToDate(timestamp: Int) -> Date {
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .medium
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone.current
        
        if let localDate = dateFormatter.date(from: dateFormatter.string(from: date)) {
            return localDate
        }else {
            return Date(timeIntervalSince1970: TimeInterval(timestamp))
        }
    }
    
}
