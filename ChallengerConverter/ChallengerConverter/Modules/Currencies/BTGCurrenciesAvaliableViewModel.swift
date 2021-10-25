//
//  BTGCurrenciesAvaliableViewModel.swift
//  ChallengerConverter
//
//  Created by ADRIANO.MAZUCATO on 22/10/21.
//

import Foundation

class BTGCurrenciesAvaliableViewModel {
    
    var currenciesAvaliable: [Currency] {
        get {
            return LocalPreferencesDataBase.shared.find() ?? []
        }
    }
    
    var currenciesToShow: [Currency] = []
    
    var didUpdateList: (()-> Void)?
    var didShowError: ((String)-> Void)?
    var didShowSpinner: ((Bool)-> Void)?
    var didShowErrorWithReload: ((String)-> Void)?
    var didSelectCurrency: ((Currency)-> Void)?
    
    let dataSource: CurrencyDatSourceProtocol
    
    init(dataSource: CurrencyDatSourceProtocol) {
        self.dataSource = dataSource
    }
}

extension BTGCurrenciesAvaliableViewModel {
    
    func viewDidLoad() {
        fetchCurrenciesAvaliable()
    }
    
    func fetchCurrenciesAvaliable() {
        if(currenciesAvaliable.isEmpty) {
            self.dataSource.currenciesAvaliable {[unowned self] currencies in
                
                //Salva a lista de moedas no Bando de Dados
                LocalPreferencesDataBase.shared.save(model: currencies)
                self.didShowSpinner?(false)
                
                currenciesToShow = currenciesAvaliable
                
                self.didUpdateList?()
            
            } fail: { [unowned self] error in
                self.didShowSpinner?(false)
                self.didShowErrorWithReload?(error+"Aqui A")
            }
        } else {
            currenciesToShow = currenciesAvaliable
            self.didUpdateList?()
        }
    }
    
    func filterCurrencies(textSearched: String) {
        currenciesToShow.removeAll()
        
        if(textSearched.isEmpty) {
            currenciesToShow.append(contentsOf: currenciesAvaliable)
            didUpdateList?()
            return
        }
        
        currenciesToShow.append(contentsOf:
                                    currenciesAvaliable.filter { currency in
                                            return currency.code.caseInsensitiveContain(textSearched) || currency.name.caseInsensitiveContain(textSearched)
                                }
        )
        
        didUpdateList?()
    }
    
    func numberCurrenciesToShow()-> Int {
        currenciesToShow.count
    }
    
    func didSelectCurrency(at index: Int) {
        self.didSelectCurrency?(currenciesToShow[index])
    }
}
