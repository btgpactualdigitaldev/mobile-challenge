//
//  ConversionsViewModel.swift
//  CurrencyConverterBTG
//
//  Created by Alex Nascimento on 23/03/21.
//

import Foundation

class ConversionsViewModel {
    
    var conversions = [Conversion]()
    
    static private let originDefaultText = "Choose a currency to convert from"
    static private let destinyDefaultText = "Choose a currency to convert to"
    static private let conversionsStorageString = "Conversions"

    private var validatedAmount: Box<Double?> = Box(nil)
    var originCurrency: Box<Currency?> = Box(nil)
    var destinyCurrency: Box<Currency?> = Box(nil)
    
    var amountText: Box<String?> = Box(nil)
    var resultText: Box<String?> = Box(nil)
    var originText: Box<String> = Box(ConversionsViewModel.originDefaultText)
    var destinyText: Box<String> = Box(ConversionsViewModel.destinyDefaultText)
    
    weak var viewController: ConversionsViewController?
    weak var coordinator: MainCoordinator?

    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencyDecimalSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    init() {
        originCurrency.bind { [unowned self] currency in
            if let currency = currency {
                self.originText.value = currency.code
                tryCalculation()
            } else {
                self.originText.value = ConversionsViewModel.originDefaultText
            }
        }
        
        destinyCurrency.bind { [unowned self] currency in
            if let currency = currency {
                self.destinyText.value = currency.code
                tryCalculation()
            } else {
                self.destinyText.value = ConversionsViewModel.destinyDefaultText
            }
        }
    }
    
    func didUpdateTextField(with text: String?) {
        if let text = text, text != "" {
            if let amount = numberFormatter.number(from: text)?.doubleValue {
                validatedAmount.value = amount
                resultText.value = ""
                tryCalculation()
            } else {
                changeDecimalSeparator()
                if let amount = numberFormatter.number(from: text)?.doubleValue {
                    validatedAmount.value = amount
                    resultText.value = ""
                    tryCalculation()
                } else {
                    // Invalid input
                    let haveSpaces = text.filter{ $0.isWhitespace }.count > 0
                    let haveUnexpectedChars = text.filter{ $0.isSymbol || $0.isLetter || $0.isMathSymbol || ($0.isPunctuation && $0 != "," && $0 != ".") }.count > 0
                    let haveMorePunctuations = text.filter{ $0 == "," || $0 == "." }.count > 1
                    // if 2 or more of the error are true show generic message
                    if [haveSpaces, haveUnexpectedChars, haveMorePunctuations].filter({$0}).count > 2 {
                        resultText.value = "Invalid Input"
                    } else if haveSpaces {
                        resultText.value = "Spaces in input"
                    } else if haveUnexpectedChars {
                        resultText.value = "Unexpected characters"
                    } else if haveMorePunctuations {
                        resultText.value = "Multiple punctuations"
                    } else {
                        resultText.value = "Invalid Input"
                    }
                }
            }
        } else {
            validatedAmount.value = nil
            resultText.value = ""
        }
    }
    
    private func changeDecimalSeparator() {
        numberFormatter.decimalSeparator = numberFormatter.decimalSeparator == "." ? "," : "."
    }
    
    private func tryCalculation() {
        guard  let origin = originCurrency.value else { return }
        guard let destiny = destinyCurrency.value else { return }
        guard let amount = validatedAmount.value else {
            amountText.value = "Give an amount to be converted"
            return
        }
        
        CurrencyLayerAPI.shared.fetchConversions { [unowned self] result in
            switch result {
            case .success(let conversionsDTO):
                self.conversions = conversionsDTO.conversions
                LocalStorage.store(conversions: conversions)
                if let result = Conversion.convert(from: origin, to: destiny, conversions: conversions, amount: amount) {
                    var resultString = "Result: "
                    resultString += numberFormatter.string(for: result) ?? ""
                    resultText.value = resultString
                    amountText.value = nil
                }
            case .failure(let error):
                switch error {
                case NetworkingError.transportError:
                    if let recovedConversions = LocalStorage.retrieveConversions() {
                        Debugger.log("Retrieving conversions from User Defaults")
                        self.conversions = recovedConversions
                    } else {
                        Debugger.log("There was a problem on your internet connection")
                        guard let viewController = viewController else { return }
                        coordinator?.showConnectionProblemAlert(error: error, sender: viewController, handler: nil)
                    }
                default:
                    Debugger.log(error.rawValue)
                }
            }
        }
    }
    
    func chooseOriringCurrency() {
        coordinator?.chooseOriringCurrency()
    }
    
    func chooseDestinyCurrency() {
        coordinator?.chooseDestinyCurrency()
    }
}
