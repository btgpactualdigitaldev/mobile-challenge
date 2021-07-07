//
//  CurrencyListViewModel.swift
//  mobile-challenge
//
//  Created by Murilo Teixeira on 26/09/20.
//

import Foundation

enum OrderCurrencies: String {
    case name = "Ordem: Nome"
    case code = "Ordem: Código"
}

class CurrencyListViewModel {
    var currencies: [CurrencyModel] = []
    var currenciesBackup: [CurrencyModel] = []
    var dateExchange: Date?
    private let networkManage = NetworkManage()
    
    let dao = CurrencyDAO()
    
    init() {
        self.orderCurrencies(by: .code)
    }
    
    func orderCurrencies(by: OrderCurrencies) {
        switch by {
        case .code:
            currencies.sort { $0.code < $1.code }
        case .name:
            currencies.sort { $0.name < $1.name }
        }
    }
    
    func search(_ searchText: String, order: OrderCurrencies) -> [CurrencyModel] {
        guard searchText.count > 0 else {
            orderCurrencies(by: order)
            return currencies
        }
        return currencies.filter({ currency in
            let code = currency.code.uppercased()
            let name = currency.name.uppercased()
            let searchText = searchText.uppercased()
            return code.contains(searchText) || name.contains(searchText)
        })
    }
    
    func fetchCurrencies(completion: @escaping (Result<[CurrencyModel], NetworkError>) -> Void) {
        let service: ConverterService = .currencyList

        networkManage.request(service: service,
                              resposeType: CurrencyListResponse.self) { result in
            switch result {
            case .success(let currenciesListResponse):
                guard let currencies = currenciesListResponse.currencies else { return }
                for (key, value) in currencies {
                    self.currencies.append(CurrencyModel(code: key, name: value))
                }
                self.orderCurrencies(by: .code)
                completion(.success(self.currencies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchValuesInDollar(completion: @escaping (Result<Date, NetworkError>) -> Void) {
        let service: ConverterService = .liveConverter
        
        networkManage.request(service: service, resposeType: CurrencyExchangeResponse.self) { result in
            switch result {
            case .success(let currencyExchangeResponse):
                guard let currenciesExchange = currencyExchangeResponse.quotes else { return }
                for (key, value) in currenciesExchange {
                    if let index = self.currencies.firstIndex(where: { key == "USD\($0.code)" }) {
                        self.currencies[index].valueDollar = value
                    }
                }
                self.dateExchange = Date(timeIntervalSince1970: currencyExchangeResponse.timestamp)
                self.currenciesBackup = self.currencies
                self.saveCurrencies()
                completion(.success(self.dateExchange ?? Date()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func saveCurrencies() {
        guard let date = dateExchange else { return }
        dao.save(currencies: currencies, dateExchange: date)
    }
    
    func retrieveCurrencies() -> [CurrencyModel]? {
        let result:(currencies: [CurrencyModel], date: Date) = dao.retrieve()
        if result.currencies.count > 0 {
            currencies = result.currencies
            currenciesBackup = result.currencies
            dateExchange = result.date
            return currencies
        }
        return nil
    }
    
    func getDollar() -> CurrencyModel? {
        let USD = Identifier.Currency.USD.rawValue
        guard let index = currencies.firstIndex(where: { $0.code == USD }) else { return nil }
        return currencies[index]
    }
}
