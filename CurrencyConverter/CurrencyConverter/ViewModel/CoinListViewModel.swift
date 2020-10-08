//
//  CoinListViewModel.swift
//  CurrencyConverter
//
//  Created by Augusto Henrique de Almeida Silva on 07/10/20.
//

import UIKit
import Network

protocol CoinListViewModelDelegate {
    func didGetListModel()
    func didErrorOcurred(error: String)
}

class CoinListViewModel {
    
    private var allCoins: [CoinViewModel] = [CoinViewModel]()
    private let monitor = NWPathMonitor()
    
    private let viewContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var exchangeRateListDataModel: [ExchangeRateList]?
    
    public private(set) var listCoins: [CoinViewModel]? {
        didSet {
            delegate?.didGetListModel()
        }
    }
    
    var delegate: CoinListViewModelDelegate?
    
    init() {
        monitorNetwork()
    }
    
    private func monitorNetwork() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.getListService()
                }
            } else {
                DispatchQueue.main.async {
                    self.fetchCurrencies()
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    private func getListService() {
        CurrencyService.shared.getList { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let model):
                if model.success ?? false {
                    var listCoins = [CoinViewModel]()
                    
                    if let currencies = model.currencies {
                        listCoins = currencies.map({ CoinViewModel(initials: $0.key, name: $0.value) })
                    }
                    
                    self.allCoins = listCoins.sorted { $0.name < $1.name }
                    
                    self.listCoins = self.allCoins
                    self.saveCurrencies(response: model)
                } else {
                    self.delegate?.didErrorOcurred(error: CoinError.invallidData.rawValue)
                }
            case .failure(let error):
                self.delegate?.didErrorOcurred(error: error.rawValue)
            }
            
        }
        
    }
    
    private func saveCurrencies(response: ExchangeRateListResponseModel) {
        if let exchangeRateListDataModel = exchangeRateListDataModel?.first {
            exchangeRateListDataModel.currencies = response.currencies
            self.exchangeRateListDataModel = [exchangeRateListDataModel]
        } else {
            let newCurrencie = ExchangeRateList(context: self.viewContext)
            newCurrencie.currencies = response.currencies
            self.exchangeRateListDataModel = [newCurrencie]
        }
        
        do {
            try self.viewContext.save()
        } catch {
            self.delegate?.didErrorOcurred(error: NSLocalizedString("save_local_error", comment: ""))
        }
    }
    
    private func fetchCurrencies() {
        do {
            self.exchangeRateListDataModel = try viewContext.fetch(ExchangeRateList.fetchRequest())
            
            if let exchangeRateList = exchangeRateListDataModel?.first {
                var listCoins = [CoinViewModel]()
                
                if let currencies = exchangeRateList.currencies {
                    listCoins = currencies.map({ CoinViewModel(initials: $0.key, name: $0.value) })
                }
                
                self.allCoins = listCoins.sorted { $0.name < $1.name }
                
                self.listCoins = self.allCoins
            } else {
                self.delegate?.didErrorOcurred(error: NSLocalizedString("local_data_empty", comment: ""))
            }
            
        } catch {
            self.delegate?.didErrorOcurred(error: NSLocalizedString("load_local_error", comment: ""))
        }
    }
    
    func filter(by text: String) {
        self.listCoins = allCoins.filter({ $0.initials.lowercased().contains(text.lowercased()) || $0.name.lowercased().contains(text.lowercased()) })
    }
    
}
