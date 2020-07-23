//
//  ConversionViewModel.swift
//  CoinConversion
//
//  Created by Ronilson Batista on 18/07/20.
//  Copyright © 2020 Ronilson Batista. All rights reserved.
//

import Foundation

// MARK: - Conversion
enum Conversion {
    case to
    case from
}

// MARK: - ConversionViewModelDelegate
protocol ConversionViewModelDelegate: class {
    func didStartLoading()
    func didHideLoading()
    func didUpdateDate(with date: String)
    func didReloadData(code: String, name: String, conversion: Conversion)
    func didReloadResult(with value: String, color: UIColor)
    func didFail(with title: String,
                 message: String,
                 buttonTitle: String,
                 noConnection: Bool,
                 dataSave: Bool
    )
}

// MARK: - Main
class ConversionViewModel {
    weak var delegate: ConversionViewModelDelegate?
    
    private var service: CurrenciesConversionService?
    private var router: ConversionRouter?
    private var conversionModel: ConversionModel?
    private var dataManager: DataManager?
    
    init(
        service: CurrenciesConversionService,
        dataManager: DataManager,
        router: ConversionRouter
    ) {
        self.service = service
        self.dataManager = dataManager
        self.dataManager?.delegate = self
        self.router = router
        self.router?.delegate = self
    }
}

// MARK: - Custom methods
extension ConversionViewModel {
    func fetchQuotes(isRefresh: Bool) {
        if !hasDatabaseQuotes() || isRefresh {
            
            delegate?.didStartLoading()
            
            service?.fetchQuotes(success: { currenciesConversion in
                self.delegate?.didHideLoading()
                
                switch currenciesConversion.success {
                case false:
                    self.handleError(whit: .init(type: .noAuthorized))
                    return
                default:
                    self.conversionModel = self.handleQuotes(
                        with: currenciesConversion
                    )
                    
                    self.delegate?.didUpdateDate(
                        with: self.conversionModel?.date?.getDateStringFromUTC() ?? "-"
                    )
                    
                    self.dataManager?.syncQuotes(with: self.conversionModel!)
                }
            }, fail: { serviceError in
                DispatchQueue.main.async {
                    self.delegate?.didHideLoading()
                    self.handleError(whit: serviceError)
                }
            })
        }
    }
    
    func fetchConvert(fromCode: String, toCode: String, value: String) {
        let convert = convertCurrency(
            fromCode: fromCode,
            toCode: toCode,
            value: value,
            conversion: conversionModel?.conversion
        )
        guard convert == nil else {
            delegate?.didReloadResult(
                with: convert!,
                color: .colorSpringGreen
            )
            return
        }
        didConversionFail()
    }
    
    func fetchCurrencies(_ conversion: Conversion) {
        router?.enqueueListCurrencies(conversion)
    }
}

// MARK: - Private Methods
extension ConversionViewModel {
    private func handleQuotes(with quotes: CurrenciesConversion) -> ConversionModel {
        let currencies = quotes.quotes.map {
            currencies -> ConversionCurrenciesModel in
            
            return ConversionCurrenciesModel(
                code: currencies.key,
                quotes: currencies.value
            )
        }
        
        return ConversionModel(date: quotes.timestamp, conversion: currencies)
    }
    
    private func findLocaleBy(whit currencyCode: String) -> Locale? {
        let locales = Locale.availableIdentifiers
        var locale: Locale?
        
        for localeId in locales {
            locale = Locale(identifier: localeId)
            
            if let code = (locale! as NSLocale).object(forKey: NSLocale.Key.currencyCode) as? String {
                if code == currencyCode {
                    return locale
                }
            }
        }
        
        return locale
    }
    
    private func convertCurrency(fromCode: String,toCode: String, value: String, conversion: [ConversionCurrenciesModel]?) -> String? {
        let currencyBase = "USD"
        
        guard let conversion = conversion else {
            return nil
        }
        guard let fetchFromQuotes = returnQuotes(conversion: conversion, currencyBase: currencyBase, code: fromCode) else {
            return nil
        }
        guard let fetchToQuotes = returnQuotes(conversion: conversion, currencyBase: currencyBase, code: toCode) else {
            return nil
        }
        guard let toQuotes = fetchToQuotes.quotes, let fromQuotes = fetchFromQuotes.quotes else {
            return nil
        }
        
        if let value = Double(value) {
            let calculate = calculateConversion(value: value, toQuotes: toQuotes, fromQuotes: fromQuotes)
            
            guard let result = formatCurrency(currencyCode: toCode, amount: String(calculate)) else {
                return nil
            }
            return result
        }
        
        if !value.isEmpty {
            return nil
        }
        
        return "-"
    }
    
    private func hasDatabaseQuotes() -> Bool {
        if dataManager?.hasDatabaseQuotes() ?? false {
            conversionModel = dataManager?.fetchDatabaseQuotes()
            guard let conversion = conversionModel else {
                fatalError("provisorio fazer tratamento")
            }
            delegate?.didUpdateDate(
                with: conversion.date?.getDateStringFromUTC() ?? "-"
            )
            return true
        }
        return false
    }
    
    private func didConversionFail() {
        delegate?.didReloadResult(
            with: "Ops... Aconteceu um erro na conversão",
            color: .colorDarkRed
        )
    }
    
    private func handleError(whit error: ServiceError) {
        guard error.type == .noConnection else {
            guard hasDatabaseQuotes() else {
                delegate?.didFail(with: "Erro encontrado",
                                  message: "Desculpe-nos pelo erro. Iremos contorná-lo o mais rápido possível. \nMotivo: \(error.type.description)",
                    buttonTitle: "OK",
                    noConnection: false,
                    dataSave: false
                )
                
                return
            }
            
            delegate?.didFail(with: "Erro encontrado",
                              message: "Desculpe-nos pelo erro. \nNão conseguimos atualizar as cotas continue navegando com os dados da última atualização.",
                              buttonTitle: "OK",
                              noConnection: false,
                              dataSave: false
            )
            return
        }
        
        guard hasDatabaseQuotes() else {
            delegate?.didFail(with: "Problema na conexão",
                              message: "Encontramos problemas com a conexão. Tente ajustá-la para continuar navegando.",
                              buttonTitle: "Tentar novamente",
                              noConnection: true,
                              dataSave: false
            )
            return
        }
        
        delegate?.didFail(with: "Problema na conexão",
                          message: "Encontramos problemas com a conexão. \nNão conseguimos atualizar as cotas continue navegando com os dados da última atualização.",
                          buttonTitle: "OK",
                          noConnection: true,
                          dataSave: true
        )
        
    }
}

// MARK: - Aux Methods
extension ConversionViewModel {
    func formatCurrency( currencyCode: String, amount: String ) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = findLocaleBy(whit: currencyCode)
        
        let numberFromField = (
            NSString(string: amount).doubleValue
            )/100
        let result = formatter.string(
            from: NSNumber(value: numberFromField)
            )!
        return result
    }
    
    func returnQuotes(conversion: [ConversionCurrenciesModel], currencyBase: String, code: String) -> ConversionCurrenciesModel? {
        if let quotes = conversion.first(
            where: { $0.code == currencyBase + code }
            ) {
            return quotes
        }
        
        return nil
    }
    
    func calculateConversion(value: Double, toQuotes: Double, fromQuotes: Double) -> Double {
        var result: Double = 0.0
        result = value * toQuotes / fromQuotes
        return result
    }
}

// MARK: - ConversionRouterDelegate
extension ConversionViewModel: ConversionRouterDelegate {
    func currencyFetched(_ code: String, _ name: String, _ conversion: Conversion) {
        delegate?.didReloadData(code: code, name: name, conversion: conversion)
    }
}

// MARK: - DataManagerDelegate
extension ConversionViewModel: DataManagerDelegate {
    func didDataManagerFail(with reason: String) {
        delegate?.didFail(with: "Erro encontrado",
                          message: "Desculpe-nos pelo erro. Não conseguimos salvar seus dados para uso off-line. \nMotivo: \(reason)",
            buttonTitle: "Continuar Navegando",
            noConnection: false,
            dataSave: false
        )
    }
}
