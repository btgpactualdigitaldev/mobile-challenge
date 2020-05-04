//
//  CurrencyEntity.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation

struct CurrencyEntity {
  
  let _id : Int
  let currencyCode: String
  let currencyName: String
  
  init(_ _id: Int, _ currencyCode: String,_ currencyName: String) {
    self._id = _id
    self.currencyCode = currencyCode
    self.currencyName = currencyName
  }
}

extension CurrencyEntity: Equatable {
  static func == (lhs: CurrencyEntity, rhs: CurrencyEntity) -> Bool {
    return
      lhs.currencyCode == rhs.currencyCode &&
        lhs.currencyName == rhs.currencyName
  }
}
