//
//  SplashViewModel.swift
//  BTGCurrency
//
//  Created by Raphael Martin on 02/08/20.
//  Copyright © 2020 Raphael Martin. All rights reserved.
//

import Foundation

class SplashViewModel {
    // Em horas
    let localDataExpirationTime = 2
    
    let currencyClient: CurrencyClientProtocol
    let userDefaults: UserDefaultsProtocol
    let networkHelper: NetworkHelperProtocol
    
    init(currencyClient: CurrencyClientProtocol, userDefaults: UserDefaultsProtocol, networkHelper: NetworkHelperProtocol) {
        self.currencyClient = currencyClient
        self.userDefaults = userDefaults
        self.networkHelper = networkHelper
    }
    
    //MARK: - Métodos principais
    func checkLastUpdate() {
        if hasStoredData() {
            if isStoredDataExpirationTimeValid() || !networkHelper.isConnected() {
                checkFavoriteCurrencies()
            } else {
                synchronizeData()
            }
        } else {
            guard networkHelper.isConnected() else {
                alert(title: "Sem conexão", message: "É necessário estar conectado na primeira vez em que o app é aberto")
                return
            }
            synchronizeData()
        }
    }
    
    func hasStoredData() -> Bool {
        // Se tem alguma data de última atualização é porque atualizou pelo menos uma vez
        return userDefaults.getDate(key: .LastUpdate) != nil
    }
    
    func isStoredDataExpirationTimeValid() -> Bool {
        if let lastUpdate = userDefaults.getDate(key: .LastUpdate) {
            let now = Date()
            let expiratedDate = Calendar.current.date(byAdding: .hour, value: localDataExpirationTime, to: lastUpdate)!
            return now <= expiratedDate
        }
        return true
    }
    
    func synchronizeData() {
        currencyClient.synchronizeQuotes { result in
            switch result {
            case .success():
                self.setSynchronized()
                self.checkFavoriteCurrencies()
            case .failure(let error):
                var msg = ""
                switch error {
                case .InvalidURL:
                    msg = "Não foi possível encontrar o serviço de câmbio."
                case .ServerError:
                    msg = "Estamos melhorando nossos serviços."
                case .InvalidResponse:
                    msg = "Não foi possível ler os valores de câmbio recebidos."
                }
                msg += " Tente novamente mais tarde"
                alert(title: "Atenção!", message: msg)
            }
        }
    }
    
    fileprivate func setSynchronized() {
        userDefaults.putDate(key: .LastUpdate, value: Date())
    }
    
    fileprivate func checkFavoriteCurrencies() {
        if let localCurrencyAbbreviation = userDefaults.getString(key: .LocalCurrency),
            let foreignCurrencyAbbreviation = userDefaults.getString(key: .ForeignCurrency),
            let localCurrency = CurrencyData.get(forAbbreviation: localCurrencyAbbreviation),
            let foreignCurrency = CurrencyData.get(forAbbreviation: foreignCurrencyAbbreviation) {
            goToExchange(localCurrency: localCurrency, foreignCurrency: foreignCurrency)
        } else {
            goToList()
        }
    }
    
    fileprivate func goToList() {
        Router.shared.setViewController(viewController: CurrenciesListViewController())
    }
    
    fileprivate func goToExchange(localCurrency: Currency, foreignCurrency: Currency) {
        Router.shared.setViewController(viewController: ExchangeViewController(localCurrency: localCurrency, foreignCurrency: foreignCurrency))
    }
}
