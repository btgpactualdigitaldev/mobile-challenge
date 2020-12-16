//
//  List.swift
//  Desafio_BTG
//
//  Created by Kleyson on 14/12/2020.
//  Copyright © 2020 Kleyson. All rights reserved.
//

import Foundation
struct List: Codable {
    let success: Bool?
    let terms: String?
    let privacy: String?
    let currencies : [String: String]?
}
