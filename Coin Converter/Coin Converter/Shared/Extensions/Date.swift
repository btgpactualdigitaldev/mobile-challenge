//
//  Date.swift
//  Coin Converter
//
//  Created by Jeferson Hideaki Takumi on 29/06/20.
//  Copyright © 2020 Takumi. All rights reserved.
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
