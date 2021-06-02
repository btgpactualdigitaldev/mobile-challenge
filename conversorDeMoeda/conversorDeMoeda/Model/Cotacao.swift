//
//  Cotacao.swift
//  conversorDeMoeda
//
//  Created by Diogenes de Souza on 21/01/21.
//

import Foundation

struct Cotacao : Codable{
    typealias DicType = [String: Double]
    let terms: URL?
    let privacy: URL?
    let quotes:DicType

}
