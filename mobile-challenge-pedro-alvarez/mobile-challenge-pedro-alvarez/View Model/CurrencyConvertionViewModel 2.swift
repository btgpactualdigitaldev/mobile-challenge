//
//  CurrencyConvertionViewModel.swift
//  mobile-challenge-pedro-alvarez
//
//  Created by Pedro Alvarez on 27/06/20.
//  Copyright © 2020 Pedro Alvarez. All rights reserved.
//
import UIKit

protocol CurrencyConvertionViewModelProtocol {
    var resultValue: NSAttributedString? { get set }
    var currencyValues: [CurrencyConvertionModel] { get }
    var delegate: CurrencyConvertionViewModelDelegate? { get set }
    
    func fetchCurrencyValues()
    func fetchConvertionResult(value: Double,
                              first: String,
                              second: String)
}

protocol CurrencyConvertionViewModelDelegate: class {
    func didGetError(_ error: String)
    func didFetchResult(_ result: NSAttributedString)
    func didFetchFirstCurrency(_ currency: String)
    func didFetchSecondCurrency(_ currency: String)
}

class CurrencyConvertionViewModel: CurrencyConvertionViewModelProtocol {
     
    var resultValue: NSAttributedString? {
        didSet {
            guard let result = resultValue else { return }
            delegate?.didFetchResult(result)
        }
    }
    
    private(set) var currencyValues: [CurrencyConvertionModel] = []
    
    private(set) var provider: CurrencyConvertionProviderProtocol
    
    weak var delegate: CurrencyConvertionViewModelDelegate?
    
    init(provider: CurrencyConvertionProviderProtocol = CurrencyConvertionProvider(),
         delegate: CurrencyConvertionViewModelDelegate? = nil) {
        self.provider = provider
        self.delegate = delegate
    }
    
    func fetchCurrencyValues() {
        provider.fetchLive { response in
            switch response {
            case .success(let json):
                self.currencyValues = CurrencyConvertionModel.getCurrencyConvertions(json.quotes)
                break
            case .error(let error):
                self.delegate?.didGetError(error.localizedDescription)
                break
            case .genericError:
                self.delegate?.didGetError(Constants.Errors.genericError)
            }
        }
    }
    
    func fetchConvertionResult(value: Double,
                              first: String,
                              second: String) {
        guard let firstModel = currencyValues.first(where: {
            $0.id == first
        }) else {
            return
        }
        guard let secondModel = currencyValues.first(where: {
            $0.id == second
        }) else {
            return
        }
        let result = CurrencyConvertionModel.convert(value: value,
                                                     first: firstModel,
                                                     second: secondModel)
        let resultString = NSAttributedString(string: "\(result.rounded(places: 2))",
                                              attributes: [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                           NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 30)])
        resultValue = resultString
    }
}


