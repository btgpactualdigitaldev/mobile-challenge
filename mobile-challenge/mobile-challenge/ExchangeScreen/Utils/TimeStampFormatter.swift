//
//  TimeStampFormatter.swift
//  mobile-challenge
//
//  Created by Bernardo Nunes on 23/11/20.
//

import Foundation

class TimeStampFormatter {
    
    static var timeStamp: String {
        let timeStamp = UserDefaults.timeStamp
        let dateTimeStamp = Date(timeIntervalSince1970: timeStamp)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: dateTimeStamp)
    }
}
