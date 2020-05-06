//
//  Date+hour.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

extension Date {
    func formattedHour() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents(.init(arrayLiteral: .hour, .minute), from: self)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
        let hourStr = hour < 10 ? "0\(hour)" : "\(hour)"
        let minuteStr = minute < 10 ? "0\(minute)" : "\(minute)"
        return "\(hourStr):\(minuteStr)"
    }
}
