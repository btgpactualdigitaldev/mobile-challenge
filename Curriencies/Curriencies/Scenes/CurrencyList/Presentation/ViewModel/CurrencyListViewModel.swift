//
//  CurrencyListViewModel.swift
//  Curriencies
//
//  Created by Ferraz on 04/09/21.
//

protocol CurrencyListViewModeling {
    var delegate: ChangeCurrencyDelegate? { get set }
    
    func numberOfSections() -> Int
    func numberOfRows() -> Int
    func cellForItemAt(_ row: Int) -> CurrencyCellModel
    func didSelectCellAt(_ row: Int)
    func heightForRowAt() -> Float
    func searchBarCancelButtonPressed()
    func search(text: String)
    func sortCurrencies(sortType: SortType)
}

protocol ChangeCurrencyDelegate: AnyObject {
    func updateNewCurrency(title: String, type: CurrencyType)
}

final class CurrencyListViewModel {
    let currencies: [CurrencyEntity]
    private(set) var currenciesPresented: [CurrencyEntity] = []
    let type: CurrencyType
    weak var delegate: ChangeCurrencyDelegate?
    
    init(currencies: [CurrencyEntity], currencyType: CurrencyType) {
        self.currencies = currencies
        self.type = currencyType
        currenciesPresented = currencies
    }
}

extension CurrencyListViewModel: CurrencyListViewModeling {
    // MARK: - TableView Delegate && Data Source
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRows() -> Int {
        currenciesPresented.count
    }
    
    func cellForItemAt(_ row: Int) -> CurrencyCellModel {
        guard currenciesPresented.count > row else {
            return CurrencyCellModel(name: "Dólar", code: "USD")
        }
        return CurrencyCellModel(name: currenciesPresented[row].name,
                                 code: currenciesPresented[row].code)
    }
    
    func didSelectCellAt(_ row: Int) {
        guard currenciesPresented.count > row else { return }
        delegate?.updateNewCurrency(title: currenciesPresented[row].code, type: type)
    }
    
    func heightForRowAt() -> Float {
        50
    }
    
    // MARK: - SearchBar Delegate
    func searchBarCancelButtonPressed() {
        currenciesPresented = currencies
    }
    
    func search(text: String) {
        if text.isEmpty {
            currenciesPresented = currencies
            return
        }
        currenciesPresented = currencies.filter({
            ($0.code.contains(text) || $0.name.contains(text))
        })
    }
    
    // MARK: - Sort Methods
    func sortCurrencies(sortType: SortType) {
        if sortType == .code {
            currenciesPresented = currenciesPresented.sorted {
                $0.code < $1.code
            }
        } else {
            currenciesPresented = currenciesPresented.sorted {
                $0.name < $1.name
            }
        }
    }
}
