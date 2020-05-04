//
//  QuoteEntity.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation

struct QuoteEntity{
  
  let _id : Int
  let from: String
  let to: String
  let value: Double
  
  init(_ _id: Int, _ from: String,_ to: String,_ value: Double) {
    self._id = _id
    self.from = from
    self.to = to
    self.value = value
  }
}

extension QuoteEntity: Equatable {
  static func == (lhs: QuoteEntity, rhs: QuoteEntity) -> Bool {
    return
      lhs.from == rhs.from &&
        lhs.to == rhs.to &&
        lhs.value == rhs.value
  }
  
}
