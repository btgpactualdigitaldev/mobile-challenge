//
//  Date+elapsedTime.swift
//  Screens
//
//  Created by Gustavo Amaral on 04/05/20.
//  Copyright © 2020 Gustavo Almeida Amaral. All rights reserved.
//

import Foundation

extension Date {
    func elapsedTime() -> String {
        let elapsed = Date().timeIntervalSince(self)
        switch elapsed {
        case 0...60: return "some seconds"
        case 61...120: return "1 minute"
        case 121...300: return "5 minutes"
        case 301...600: return "10 minutes"
        case 601...1800: return "30 minutes"
        case 1801...3600: return "1 hour"
        case 3601...7200: return "2 hours"
        case 7201...: return "some hours"
        default: return "long time"
        }
    }
}
