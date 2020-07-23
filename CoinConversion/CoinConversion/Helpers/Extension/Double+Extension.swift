//
//  Double+Extension.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 22/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeZone = .current
        let localDate = dateFormatter.string(from: date)
        
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateFormatter.dateStyle = DateFormatter.Style.none
        dateFormatter.timeZone = .current
        let localTime = dateFormatter.string(from: date)
        
        return "Cota Atualizado em: \(localDate) às \(localTime)"
    }
}
