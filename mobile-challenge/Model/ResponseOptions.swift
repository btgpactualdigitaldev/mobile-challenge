//
//  ResponseOptions.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation

enum ResponseOptionsCurrency {
  
  case SucessResponse(CurrencyResponse)
  case ErrorResponse(String)
  
}

enum ResponseOptionsQuote {
  
  case SucessResponse(QuoteResponse)
  case ErrorResponse(String)
  
}
