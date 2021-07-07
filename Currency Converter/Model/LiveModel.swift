//
//  LiveModel.swift
//  Currency Converter
//
//  Created by Otávio Souza on 30/09/20.
//

import UIKit

struct LiveModel: Codable {
    let success : Bool
    let quotes : Dictionary<String, Double>
    
    init() {
        success = false
        quotes = Dictionary()
    }
    
    private enum CodingKeys: String, CodingKey {
        case success = "success"
        case quotes = "quotes"
    }

}
