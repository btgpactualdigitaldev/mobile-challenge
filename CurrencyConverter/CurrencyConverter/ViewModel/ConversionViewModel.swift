//
//  ConversionViewModel.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import Network
import UIKit

protocol ConversionViewModelDelegate {
    func didConvertValue(value: String)
    func didErrorOcurred(error: String)
    func setLastUpdate(text: String)
}

class ConversionViewModel {
    
    var delegate: ConversionViewModelDelegate?
    private let monitor = NWPathMonitor()
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var value: Double? {
        didSet {
            self.convert()
        }
    }
    
    private var coinOrigin: CoinViewModel? {
        didSet {
            self.convert()
        }
    }
    
    private var coinDestiny: CoinViewModel? {
        didSet {
            self.convert()
        }
    }
    
    private var currentQuote: CurrentQuoteResponseModel = CurrentQuoteResponseModel()
    private var currentQuoteDataModel: [CurrentQuote]?
    
    init() {
        monitorNetwork()
    }
    
    private func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.getQuoteService()
                }
            } else {
                DispatchQueue.main.async {
                    self.fetchQuotes()
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    func getQuoteService() {
        CurrencyService.shared.getQuote { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                if model.success ?? false {
                    self.currentQuote = model
                    self.saveQuotes(response: model)
                    
                    self.setLastUpdate()
                    
                } else {
                    self.delegate?.didErrorOcurred(error: CoinError.invallidData.rawValue)
                }
            case .failure(let error):
                self.delegate?.didErrorOcurred(error: error.rawValue)
            }
        }
    }
    
    private func saveQuotes(response: CurrentQuoteResponseModel) {
        if let currentQuote = currentQuoteDataModel?.first {
            currentQuote.timestamp = Int64(response.timestamp ?? 0)
            currentQuote.quotes = response.quotes
            self.currentQuoteDataModel = [currentQuote]
        } else {
            let newQuote = CurrentQuote(context: self.viewContext)
            newQuote.timestamp = Int64(response.timestamp ?? 0)
            newQuote.quotes = response.quotes
            self.currentQuoteDataModel = [newQuote]
        }
        
        do {
            try self.viewContext.save()
        } catch {
            self.delegate?.didErrorOcurred(error: NSLocalizedString("save_local_error", comment: ""))
        }
    }
    
    private func fetchQuotes() {
        do {
            self.currentQuoteDataModel = try viewContext.fetch(CurrentQuote.fetchRequest())
            
            let quoteResponses = currentQuoteDataModel?.map( { CurrentQuoteResponseModel(success: Optional(true), terms: Optional(nil), privacy: Optional(nil), timestamp: Optional(Int($0.timestamp)), source: Optional(nil), quotes: $0.quotes)
            })
            
            if let currentQuote = quoteResponses?.first {
                self.currentQuote = currentQuote
                self.setLastUpdate()
            } else {
                self.delegate?.didErrorOcurred(error: NSLocalizedString("local_data_empty", comment: ""))
            }
            
        } catch {
            self.delegate?.didErrorOcurred(error: NSLocalizedString("load_local_error", comment: ""))
        }
    }
    
    private func setLastUpdate() {
        if let timestamp = self.currentQuote.timestamp {
            let dateFormatted = Date.formatter(timestamp: timestamp)
            self.delegate?.setLastUpdate(text: dateFormatted)
        }
    }
    
    func setValue(value: Double) {
        self.value = value
    }
    
    func setOriginCoin(model: CoinViewModel) {
        self.coinOrigin = model
    }
    
    func setDestinyCoin(model: CoinViewModel) {
        self.coinDestiny = model
    }
    
    func convert() {
        
        if let value = self.value, let coinOrigin = self.coinOrigin, let coinDestiny = self.coinDestiny {
            if coinOrigin.initials.elementsEqual(coinDestiny.initials) {
                formatConvertedValue(value: value)
            } else if coinOrigin.initials.contains("USD") {
                guard let destinyQuote = currentQuote.quotes?["USD" + coinDestiny.initials] else { return }
                let value = value * destinyQuote
                formatConvertedValue(value: value)
            } else if coinDestiny.initials.contains("USD") {
                guard let originQuote = currentQuote.quotes?["USD" + coinOrigin.initials] else { return }
                let value = value / originQuote
                formatConvertedValue(value: value)
            } else {
                guard let originQuote = currentQuote.quotes?["USD" + coinOrigin.initials] else { return }
                guard let destinyQuote = currentQuote.quotes?["USD" + coinDestiny.initials] else { return }
                
                let value = (value * destinyQuote ) / originQuote
                formatConvertedValue(value: value)
            }
        }
    }
    
    func formatConvertedValue(value: Double) {
        var result = String(format: " %.2f", value)
        result.insert(contentsOf: self.coinDestiny?.initials ?? "", at: result.startIndex)
        delegate?.didConvertValue(value: value == 0 ? "": result)
    }
}
