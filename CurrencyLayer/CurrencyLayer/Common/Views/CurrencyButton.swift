//
//  CurrencyButton.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 14/12/20.
//

import SwiftUI

struct CurrecyButton: View {
  @Binding var currencyItem: String
  var body: some View {
    HStack {
      Image("ic_arrow_down")
        .resizable()
        .foregroundColor(Color.white)
        .frame(width: 15, height: 15)

      Text(currencyItem)
        .foregroundColor(Color.white)

    }
  }
}
