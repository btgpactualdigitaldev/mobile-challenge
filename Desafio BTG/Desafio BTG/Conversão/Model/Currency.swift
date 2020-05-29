//
//  Currency.swift
//  Desafio BTG
//
//  Created by Vinícius Brito on 25/05/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import Foundation
import SwiftyJSON

class Currency: NSObject {
    
    var dict = [String:JSON]()
        
    // MARK: - Parse Currency list
    
    static func parseList(json: JSON) -> Currency {
        let list = Currency()
        list.dict = json["currencies"].dictionaryValue
        return list
    }
    
}
