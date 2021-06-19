//
//  LastUpdate.swift
//  app-mobile-challenge
//
//  Created by Matheus Silva on 29/11/20.
//

import Foundation

final class LastUpdate {
    static func get() -> String {
        let timestamp = CommonData.shared.lastUpdate
        if (timestamp == .zero) { return "Buscando atualizações..." }
        let date = Date(timeIntervalSince1970: TimeInterval(timestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "BRT")
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yyyy - HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}
