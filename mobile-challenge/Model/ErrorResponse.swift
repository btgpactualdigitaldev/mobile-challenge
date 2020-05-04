//
//  ErrorResponse.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation


struct ErrorResponse : Codable {
  
  let success: Bool
  let error: ErrorInfo
  
}

struct ErrorInfo : Codable {
  
  let code: Int
  let type: String
  let info: String
  
}
