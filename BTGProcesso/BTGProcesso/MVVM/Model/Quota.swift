//
//  Quota.swift
//  BTGProcesso
//
//  Created by Lelio Jorge Junior on 07/12/20.
//

import Foundation




struct Quota: Decodable {
    var success: Bool
    var source: String
    var quotes: [String: Float]
}
