//
//  CambioMapper.swift
//  AppCambio
//
//  Created by Visão Grupo on 8/21/20.
//  Copyright © 2020 Vinicius Teixeira. All rights reserved.
//

import Foundation

struct CambioMapper: Decodable {
    
    // MARK: Properties
    
    var quotes: [String: Double]
}
