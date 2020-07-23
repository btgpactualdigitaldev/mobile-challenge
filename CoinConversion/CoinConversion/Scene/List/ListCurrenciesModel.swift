//
//  ListCurrenciesModel.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 20/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

class ListCurrenciesModel: NSObject {
    var name = String()
    var code = String()
    
    init(name: String, code: String) {
        self.name = name
        self.code = code
    }
}
