//
//  Currency.swift
//  DesafioBTG
//
//  Created by Bittencourt Mantavani, Rômulo on 02/09/20.
//  Copyright © 2020 Bittencourt Mantovani, Rômulo. All rights reserved.
//

import Foundation

struct Currency {
    var name: String
    var code: String
    var valueOfUSD: Double?
    var isUSD: Bool {
        return code == "USD"
    }
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
    
    init(json: [String: Any]) {
        let unicJson = json.first
        self.code = unicJson?.key ?? ""
        self.name = unicJson?.value as? String ?? ""
    }
    
}

