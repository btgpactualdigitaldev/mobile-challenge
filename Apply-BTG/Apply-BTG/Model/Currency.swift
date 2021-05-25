//
//  Currency.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 21/05/21.
//

import Foundation

struct Currency: Identifiable, Codable {
    let code: String
    let name: String
    
    var id: String {
        return code
    }
}
