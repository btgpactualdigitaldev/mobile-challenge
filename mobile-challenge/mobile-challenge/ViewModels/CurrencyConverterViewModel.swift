//
//  CurrencyConverterViewModel.swift
//  mobile-challenge
//
//  Created by gabriel on 29/11/20.
//

import Foundation

public struct ConvertResponse {
    let input: String
    let output: String
}

class CurrencyConverterViewModel {
    
    // MARK: Delegate
    weak var delegate: CurrencyConverterViewModelDelegate?
    
    // MARK: Coordinator
    weak var coordinator: CurrencyConverterCoordinator?
    
    // MARK: Variables
    private var quotes: CurrencyQuotes?
    
    private var currencyList: CurrencyList?
    
    private(set) var originCurrency: String = "" {
        didSet {
            delegate?.originChanged()
        }
    }
    private(set) var destinyCurrency: String = "" {
        didSet {
            delegate?.destinyChanged()
        }
    }
    
    private var isQuotesFetched: Bool = false {
        didSet {
            if isCurrenciesFetched && isQuotesFetched {
                dataLoaded()
            }
        }
    }
    private var isCurrenciesFetched: Bool = false {
        didSet {
            if isCurrenciesFetched && isQuotesFetched {
                dataLoaded()
            }
        }
    }
    
    private var currencyFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.positiveInfinitySymbol = "Valor inválido"
        numberFormatter.alwaysShowsDecimalSeparator = false
        numberFormatter.decimalSeparator = Locale.current.decimalSeparator
        numberFormatter.groupingSeparator = Locale.current.groupingSeparator
        return numberFormatter
    }()
    
    static let quotesCacheKey = "CurrencyQuotes"
    static let currenciesCacheKey = "CurrencyList"
    
    // MARK: Methods
    /**
     Call the methods to get the latests currencies and their respective quotes.
     */
    func start() {
        requestQuotes()
        requestCurrencyList()
    }
    
    /**
     Make the request to get the latests currencies quotes.
     */
    private func requestQuotes() {
        quotes = nil
        isQuotesFetched = false
        
        CurrencyService.getQuotes { [weak self] (answer) in
            self?.quotesFetched(answer)
        }
    }
    
    /**
     Deal with quotes data task answer. Delegating an error alert if needed.
     
     - Parameter answer: The data task answer.
     */
    private func quotesFetched(_ answer: TaskAnswer<Any>) {
        switch answer {
        case .result(let quotes as CurrencyQuotes):
            self.quotes = quotes
        case .error(_ as DataTaskError):
            guard let quotes = getCachedQuotes() else {
                self.delegate?.createAlert(title: "Ocorreu um erro", message: "Verifique o status da sua conexão.", handler: nil)
                return
            }
            self.quotes = quotes
        case .error(let error as URLParsingError):
            guard let quotes = getCachedQuotes() else {
                self.delegate?.createAlert(title: "Erro \(error.code)", message: "Entre em contato com o administrador.", handler: nil)
                return
            }
            self.quotes = quotes
        default:
            guard let quotes = getCachedQuotes() else {
                self.delegate?.createAlert(title: "Erro genérico", message: "Entre em contato com o administrador.", handler: nil)
                return
            }
            self.quotes = quotes
        }
        
        self.isQuotesFetched = true
    }
    
    /**
     Make the request to get the available currencies.
     */
    private func requestCurrencyList() {
        currencyList = nil
        isCurrenciesFetched = false
        
        CurrencyService.getCurrencyList { [weak self] (answer) in
            self?.currenciesFetched(answer)
        }
    }
    
    /**
     Deal with quotes data task answer. Delegating an error alert if needed.
     
     - Parameter answer: The data task answer.
     */
    private func currenciesFetched(_ answer: TaskAnswer<Any>) {
        switch answer {
        case .result(let currencies as CurrencyList):
            self.currencyList = currencies
        case .error(_ as DataTaskError):
            guard let currencies = getCachedCurrencies() else {
                self.delegate?.createAlert(title: "Ocorreu um erro", message: "Verifique o status da sua conexão.", handler: nil)
                return
            }
            self.currencyList = currencies
        case .error(let error as URLParsingError):
            guard let currencies = getCachedCurrencies() else {
                self.delegate?.createAlert(title: "Erro \(error.code)", message: "Entre em contato com o administrador.", handler: nil)
                return
            }
            self.currencyList = currencies
        default:
            guard let currencies = getCachedCurrencies() else {
                self.delegate?.createAlert(title: "Erro genérico", message: "Entre em contato com o administrador.", handler: nil)
                return
            }
            self.currencyList = currencies
        }
        
        self.isCurrenciesFetched = true
    }
    
    /**
     Set quotes to User Defaults.
     
     - Parameter currencies: The quotes to cache.
     */
    private func setCachedQuotes(_ quotes: CurrencyQuotes) {
        let userDefaults = UserDefaults.standard
        if let encodedQuotes = try? JSONEncoder().encode(quotes) {
            userDefaults.setValue(encodedQuotes, forKey: CurrencyConverterViewModel.quotesCacheKey)
        }
    }
    
    /**
     Attempts to retrieve cached quotes from User Defaults.
     */
    private func getCachedQuotes() -> CurrencyQuotes? {
        let userDefaults = UserDefaults.standard
        
        guard let encodedQuotes = userDefaults.object(forKey: CurrencyConverterViewModel.quotesCacheKey) as? Data,
              let quotes = try? JSONDecoder().decode(CurrencyQuotes.self, from: encodedQuotes) else {
            return nil
        }
        
        delegate?.createAlert(title: "Atenção", message: "Os dados apresentados podem estar desatualizados. Verifique o status da sua conexão.", handler: nil)
        
        return quotes
    }
    
    /**
     Set currencies to User Defaults.
     
     - Parameter currencies: The currencies to cache.
     */
    private func setCachedCurrencies(_ currencies: CurrencyList) {
        let userDefaults = UserDefaults.standard
        if let encodedCurrencies = try? JSONEncoder().encode(currencies) {
            userDefaults.setValue(encodedCurrencies, forKey: CurrencyConverterViewModel.currenciesCacheKey)
        }
    }
    
    /**
     Attempts to retrieve cached currencies from User Defaults.
     */
    private func getCachedCurrencies() -> CurrencyList? {
        let userDefaults = UserDefaults.standard
        
        guard let encodedCurrencies = userDefaults.object(forKey: CurrencyConverterViewModel.currenciesCacheKey) as? Data,
              let currencies = try? JSONDecoder().decode(CurrencyList.self, from: encodedCurrencies) else {
            return nil
        }
        
        delegate?.createAlert(title: "Atenção", message: "Os dados apresentados podem estar desatualizados. Verifique o status da sua conexão.", handler: nil)
        
        return currencies
    }
    
    /**
     Convert currency from input text to an formatted new input and a converted output.
     
     - Parameter text: The text with the currency to be converted.
     */
    func convert(_ text: String?) -> ConvertResponse {
        if let inputText = text, !inputText.isEmpty {
            let originValue = prepareCurrencyInput(inputText)
                            
            // Text has a valid currency
            if let originValue = originValue,
               let valueConverted = convert(originValue, from: originCurrency, to: destinyCurrency) {
                
                currencyFormatter.currencyCode = originCurrency
                let input = currencyFormatter.string(from: originValue as NSNumber)
                
                currencyFormatter.currencyCode = destinyCurrency
                let output = currencyFormatter.string(from: valueConverted as NSNumber)
                return ConvertResponse(input: input ?? "", output: output ?? "")
            }
        }
        return ConvertResponse(input: "", output: "")
    }
    
    /**
     Convert the value from origin currency to destiny currency.
     
     - Parameter value: The amount to be converted.
     - Parameter origin: The currency of the amount.
     - Parameter destiny: The desired currency to convert for.
     */
    private func convert(_ value: Double, from origin: String, to destiny: String) -> Double? {
        let usdOriginKey = "USD" + origin
        let usdDestinyKey = "USD" + destiny
                
        guard let quotes = self.quotes,
              let originUSD = quotes.quotes[usdOriginKey],
              let destinyUSD = quotes.quotes[usdDestinyKey] else {
            return nil
        }
        
        // Converting from origin currency to USD then to destiny currency
        return (value / originUSD) * destinyUSD
    }
    
    /**
     Prepares the text to accept any currency removing non-digit characters expect for the separator.
     */
    private func prepareCurrencyInput(_ text: String) -> Double? {
        var inputText = text
        
        // Enable separator input
        currencyFormatter.alwaysShowsDecimalSeparator = inputText.last?.description == Locale.current.decimalSeparator ? true : false
        // Enable decimal character for 0 digit
        let splitString = inputText.split(separator: Character(Locale.current.decimalSeparator ?? ""))
        currencyFormatter.minimumFractionDigits = splitString.count > 1 && splitString[1].last?.description == "0" ? 1 : 0
        
        // Remove every non digit character except decimal separator
        inputText.removeAll(where: {Double($0.description) == nil && $0.description != Locale.current.decimalSeparator})
        inputText = inputText.replacingOccurrences(of: Locale.current.decimalSeparator ?? "", with: ".")
        
        return Double(inputText)
    }
    
    /**
     Set currency origin.
     
     - Parameter origin: The target currency origin.
     */
    func setOrigin(for currency: Currency) {
        self.originCurrency = currency.symbol
    }
    
    /**
     Set currency destiny.
     
     - Parameter destiny: The target currency destiny.
     */
    func setDestiny(for currency: Currency) {
        self.destinyCurrency = currency.symbol
    }
    
    /**
     Returns if currency conversion is available to the current origin and destiny. If not available it asks the delegate to create an alert.
     */
    func isConvertEnabled() -> Bool {
        let isOriginValid = currencyList?.currencies.contains(where: {$0.symbol == originCurrency}) ?? false
        let isDestinyValid = currencyList?.currencies.contains(where: {$0.symbol == destinyCurrency}) ?? false
        let isValid = isOriginValid && isDestinyValid
        
        if !isValid {
            delegate?.createAlert(title: "Ops!", message: "Selecione a moeda de origem e destino.", handler: nil)
        }
        return isValid
    }
    
    private func dataLoaded() {
        // Finished assyncronous data tasks
        
        // If quotes or currencies is nil try to get from cache
        guard let quotes = quotes,
              let currencyList = currencyList else {
            self.quotes = getCachedQuotes()
            self.currencyList = getCachedCurrencies()
            delegate?.dataFetched()
            return
        }
        
        setCachedQuotes(quotes)
        setCachedCurrencies(currencyList)
        
        // Tells the delegate that it finished fetching the data
        delegate?.dataFetched()
    }
    
    private func getCurrencyList() -> CurrencyList? {
        // Show an alert if there is no CurrencyList
        if currencyList == nil {
            delegate?.createAlert(title: "Ocorreu um erro", message: "Verifique o status da sua conexão e deslize para cima para tentar novamente.", handler: nil)
        }
        return currencyList
    }
    
    private func getQuotes() -> CurrencyQuotes? {
        // Show an alert if there is no CurrencyList
        if quotes == nil {
            delegate?.createAlert(title: "Ocorreu um erro", message: "Verifique o status da sua conexão e deslize para cima para tentar novamente.", handler: nil)
        }
        return quotes
    }
    
    /**
     Asks the coordinator to deal with the transition for the specific currency type.
     
     - Parameter type: The button's type.
     */
    func buttonDidTap(_ type: CurrencyType) {
        guard let currencyList = getCurrencyList() else {
            return
        }
        
        coordinator?.selectCurrencyButtonDidTap(currencyList, for: type)
    }
    
    /**
     Returns the formatted date of quotes last update if available.
     */
    func getLastUpdate() -> String? {
        guard let quotes = getQuotes(),
              getCurrencyList() != nil,
              let lastUpdate = quotes.lastUpdate.gmtToCurrent(dateFormat: "dd/MM/yyyy HH:mm") else {
            return nil
        }
        return lastUpdate
    }
    
}
