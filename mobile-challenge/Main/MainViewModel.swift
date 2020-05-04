//
//  MainViewModel.swift
//  mobile-challenge
//
//  Created by Kivia on 5/2/20.
//  Copyright © 2020 AP Club. All rights reserved.
//

import Foundation

class MainViewModel {
  
  // MARK: - Init
  
  // Handle Error
  let error = Observable<String>()
  
  // Live currency value
  let liveValue = Observable<Double>()
  
  // Update "FROM" button
  let fromCode = Observable<String>()
  
  // Update "TO" button
  let toCode = Observable<String>()
  
  var currencyList = [] as [CurrencyEntity]
  var quotes = [] as [QuoteEntity]
  var currencyFrom = 1.0
  var currencyTo = 1.0
  var dataBase : AppDataBase?
  
  init(application: AppDelegate) {
    Thread.printCurrent(method: "init - MainViewModel")
    dataBase = application.dataBase
    guard let clientApi = application.clientApi else { return }
    getQuote(clientApi)
    getCurrency(clientApi)
  }
  
  // MARK: - Handle Currency
  
  private func getCurrency(_ clientApi: ClientApi) {
    Dispatch.background {
      clientApi.fetchCurrencyList { (response) in
        switch (response) {
        case .SucessResponse(let data): do {
          self.handleCurrencySucess(data)
          }
        case .ErrorResponse(let message): do {
          print("ErrorResponse Currency\(message)")
          self.error.value = message
          self.setCurrencyFromDb()
          }
        }
      }
    }
  }
  
  private func handleCurrencySucess(_ data: (CurrencyResponse)) {
    if data.success || !data.currencies.isEmpty{
      self.updateCurrencyTableDB(data: data)
    } else {
      print("False Success Currency")
      self.error.value = "Error while fetching data"
      self.setCurrencyFromDb()
    }
  }
  
  private func updateCurrencyTableDB(data: CurrencyResponse){
    let sortedCurrency = data.currencies.sorted(by: { (first, second) -> Bool in
      first.key < second.key
    })
    var id = 1
    var list = [] as [CurrencyEntity]
    sortedCurrency.forEach { (dic) in
      let currency = CurrencyEntity(
        id,
        dic.key,
        dic.value)
      list.append(currency)
      id+=1
    }
    self.currencyList = list
    Dispatch.background {
      self.dataBase?.insertOrUpdateListCurrencyEntityTable(list: list)
    }
  }
  
  private func setCurrencyFromDb() {
    Dispatch.background {
      let list = self.dataBase?.selectAllCurrencyEntityTable()
      if (list!.count > 0) {
        self.currencyList = list!
      }
    }
  }
  
  // MARK: - Handle Quote
  
  private func getQuote(_ clientApi: ClientApi) {
    Dispatch.background {
      clientApi.fetchQuoteLive { (response) in
        switch (response) {
        case .SucessResponse(let data): do {
          self.handleQuoteSucess(data)
          }
        case .ErrorResponse(let message): do {
          print("ErrorResponse Quote\(message)")
          self.error.value = message
          self.setQuoteFromDb()
          }
        }
      }
    }
  }
  
  private func handleQuoteSucess(_ data: (QuoteResponse)) {
    if data.success || !data.quotes.isEmpty{
      updateQuoteTableDB(data: data)
      setQuoteValue(code: "BRL", type: "TO")
    } else {
      print("False Success Quote")
      self.error.value = "Error while fetching data"
      self.setQuoteFromDb()
    }
  }
  
  func updateQuoteTableDB(data: QuoteResponse) {
    let sortedQuotes = data.quotes.sorted(by: { (first, second) -> Bool in
      first.key < second.key
    })
    var id = 1
    var quoteList = [] as [QuoteEntity]
    sortedQuotes.forEach { (quote) in
      let quoteEntity = QuoteEntity(
        id,
        quote.key.substring(to: 3),
        quote.key.substring(from: 3),
        quote.value)
      quoteList.append(quoteEntity)
      id+=1
    }
    self.quotes = quoteList
    Dispatch.background {
      self.dataBase?.insertOrUpdateListQuoteEntityTable(list: quoteList)
    }
  }
  
  private func setQuoteFromDb() {
    Dispatch.background {
      let quoteList = self.dataBase?.selectAllQuoteEntityTable()
      if (quoteList!.count > 0) {
        self.quotes = quoteList!
        self.setQuoteValue(code: "BRL", type: "TO")
      }
    }
  }
  
  func setQuoteValue(code: String, type: String) {
    let value = self.quotes.filter { (quote) -> Bool in quote.to == code }
    print("QUOTE value \(String(describing: value))")
    if (value as [QuoteEntity]?) != nil && value.count > 0 {
      if (type == "FROM") {
        self.currencyFrom = 1 / value[0].value
        fromCode.value = (code)
      } else {
        self.currencyTo = value[0].value
        toCode.value = (code)
      }
      liveValue.value = (currencyFrom * currencyTo)
    }
  }
}
