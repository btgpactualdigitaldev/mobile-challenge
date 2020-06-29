//
//  CurrencyListViewModel.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol CurrencyListViewModelProtocol {
    var delegate: CurrencyListViewModelDelegate? { get set }
    var currencyList: [CurrencyListModel] { get }
    var currenciesViewModel: [NSAttributedString] { get  }
    var filteredCurrencyList: [NSAttributedString] { get }
    
    func fetchCurrencies()
    func didSelectCurrency(index: Int)
    func sortCurrencyList(withTag tag: Int)
    func filterContentForSearchText(_ text: String)
}

protocol CurrencyListViewModelDelegate: class {
    func didFetchSelectedCurrency(id: String)
    func didFetchCurrencies()
    func didGetError(_ error: String)
}

class CurrencyListViewModel: CurrencyListViewModelProtocol {
    
    private(set) var currencyList: [CurrencyListModel] = [] {
        didSet {
            currenciesViewModel = convertCurrencyViewModel(currencyList)
        }
    }
    
    private(set) var filteredCurrencyList: [NSAttributedString] = [] {
        didSet {
            delegate?.didFetchCurrencies()
        }
    }
    
    private(set) var selectedCurrencyId: String? {
        didSet {
            guard let id = selectedCurrencyId else { return }
            delegate?.didFetchSelectedCurrency(id: id)
        }
    }
    
    private(set) var currenciesViewModel: [NSAttributedString] = [] {
        didSet {
            filteredCurrencyList = currenciesViewModel
        }
    }
    
    private(set) var provider: CurrencyListProviderProtocol
    
    weak var delegate: CurrencyListViewModelDelegate?
    
    init(provider: CurrencyListProviderProtocol = CurrencyListProvider(),
         delegate: CurrencyListViewModelDelegate? = nil) {
        self.provider = provider
        self.delegate = delegate
    }
    
    func fetchCurrencies() {
        provider.fetchList { response in
            switch response {
            case .success(let model):
                self.currencyList = CurrencyListModel.getCurrencyList(fromJson: model.currencies).sorted(by: { $0.id < $1.id })
                break
            case .error(let error):
                self.delegate?.didGetError(error.localizedDescription)
                break
            case .genericError:
                self.delegate?.didGetError(Constants.Errors.genericError)
                break
            }
        }
    }
    
    func didSelectCurrency(index: Int) {
        let id = currencyList[index].id
        delegate?.didFetchSelectedCurrency(id: id)
    }
    
    func sortCurrencyList(withTag tag: Int) {
        if tag == 0 {
            currencyList.sort(by: {
                $0.id < $1.id
            })
        } else {
            currencyList.sort(by: {
                $0.fullName < $1.fullName
            })
        }
        currenciesViewModel = convertCurrencyViewModel(currencyList)
    }
    
    func filterContentForSearchText(_ text: String) {
        if text.isEmpty {
            filteredCurrencyList = currenciesViewModel
        } else {
            filteredCurrencyList = currenciesViewModel.filter({ $0.string.lowercased().contains(text.lowercased())})
        }
    }
}

extension CurrencyListViewModel {
    
    private func convertCurrencyViewModel(_ currencies: [CurrencyListModel]) -> [NSAttributedString] {
        var attributesStrings: [NSAttributedString] = []
        for currency in currencies {
            attributesStrings.append(NSAttributedString(string: currency.id + .space + currency.fullName,
                                                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.currencyLblColor, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15)]))
        }
        return attributesStrings
    }
}
