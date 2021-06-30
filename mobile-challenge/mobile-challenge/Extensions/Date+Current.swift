//
//  Date+Current.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

extension Date {
    
    /**
     Get time description converted to current time zone
     
     - Parameter dateFormat: Desired format of the return
     */
    func gmtToCurrent(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.timeZone = TimeZone.current
        
        let dateString = dateFormatter.string(from: self)
        
        // Invalid format
        guard let _ = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        return dateString
    }
}
