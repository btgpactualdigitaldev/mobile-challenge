//
//  QuoteLiveResponse.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation

struct QuoteResponse : Codable {
  
  let success: Bool
  let terms: String
  let privacy: String
  let timestamp: Int64
  let source: String
  let quotes: Dictionary<String, Double>
  
}
