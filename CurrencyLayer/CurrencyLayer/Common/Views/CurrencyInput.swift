//
//  CurrencyInput.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 12/12/20.
//

import SwiftUI

struct CurrencyInput: View {
  var model: CurrencyInputModel
  var body: some View {
      let binding = Binding<String>(get: { () -> String in
          return String(format: "%.2f", self.model.value)
      }) { (s) in
          var s = s
          s.removeAll { (c) -> Bool in
              !c.isNumber
          }
          self.model.txt = s
      }
      return TextField("0.00", text: binding)
              .keyboardType(.decimalPad)
              .foregroundColor(Color.white)
  }
}

struct CurrencyInputModel {
    @Binding var txt: String
  
    var value: Double {
        (Double(self.txt) ?? 0.0) / 100
    }
}
