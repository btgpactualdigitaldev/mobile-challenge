//
//  MoedaMapper.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import Foundation

struct MoedaMapper: Decodable {
    
    // MARK: Properties
    
    var currencies: [String: String]
}
