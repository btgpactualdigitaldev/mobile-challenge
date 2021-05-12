//
//  AvailableCurrencies.swift
//  CurrencyLayer
//
//  Created by Filipe Cruz on 12/12/20.
//

import SwiftUI

struct AvailableCurrencies: View {
  @Environment(\.presentationMode) var presentation
  
  var currencies: [String: String]
  @Binding var currencyItem: String
  var screenWidth = UIScreen.main.bounds.width
  @State private var searchQuery: String = ""

  var body: some View {
      List {
          Section(header: searchHeader) {
            ForEach(currencies.sorted(by: <).filter {
                self.searchQuery.isEmpty ?
                    true :
                    "\($0)".contains(self.searchQuery)
            }, id: \.key) { key, value in
                HStack {
                  Text(key + " - " + value)
                  Spacer()
                }
                .contentShape(Rectangle())
                .frame(
                    maxWidth: .infinity,
                    maxHeight: 150,
                    alignment: .center
                )
                .padding(16)
                .listRowInsets(EdgeInsets())
                .onTapGesture { setChoosenCurrencieAndDismiss(key: key) }
            }
          }
      .navigationBarTitle(Text("Supported currencies"))
      .listStyle(GroupedListStyle())
    }
  }
    
  private var searchHeader: some View {
    return SearchBar(text: self.$searchQuery)
  }

  func setChoosenCurrencieAndDismiss(key: String) {
    self.currencyItem = key
    self.presentation.wrappedValue.dismiss()
  }
}
