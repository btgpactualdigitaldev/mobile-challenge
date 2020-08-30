//
//  ListaMoedaCotacaoResponse.swift
//  conversor_moeda
//
//  Created by Eric Soares Filho on 27/08/20.
//  Copyright © 2020 erimia. All rights reserved.
//

import Foundation

struct ListaMoedaCotacaoResponse: Decodable {
    var quotes: [String: Double]?
    
    enum CodingKeys: String, CodingKey {
        case quotes
    }
}
