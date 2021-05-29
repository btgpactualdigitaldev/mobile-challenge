//
//  QuotationModel.swift
//  mobile-challenge
//
//  Created by Caio Azevedo on 25/11/20.
//

import Foundation

struct Quotation: Decodable {
    var success: Bool
    var error: ErrorCode?
    var timestamp: Int?
    var quotes: [String: Double]
}
