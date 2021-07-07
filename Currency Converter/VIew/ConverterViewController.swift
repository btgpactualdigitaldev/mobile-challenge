//
//  ViewController.swift
//  Currency Converter
//
//  Created by Otávio Souza on 28/09/20.
//

import UIKit

protocol ConverterViewControllerProtocol {
    func showModalCurrencyList(type: CurrencyType)
}

class ConverterViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var textFrom: UITextField!
    @IBOutlet weak var textTo: UITextField!
    @IBOutlet weak var textValueIn: UITextField!
    @IBOutlet weak var textValueOut: UITextField!
    
    var from: String!
    var to: String!
    
    var convertViewModel = ConvertViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let tapFrom = UITapGestureRecognizer(target: self, action: #selector(SelectFrom))
        tapFrom.delegate = self
        textFrom.addGestureRecognizer(tapFrom)
        
        let tapTo = UITapGestureRecognizer(target: self, action: #selector(selectTo))
        tapTo.delegate = self
        textTo.addGestureRecognizer(tapTo)
        textValueIn.delegate = self
    }
    
    @IBAction func SelectFrom(_ sender: Any) {
        showModalCurrencyList(type: .from)
    }
    @IBAction func selectTo(_ sender: Any) {
        showModalCurrencyList(type: .to)
    }
    
    @IBAction func convert(_ sender: Any?) {
        if !isValidaFields() {
            return
        }
        
        if let from = from,
           let to = to,
           let stringValue = textValueIn.text,
           let value = Double(stringValue) {
            convertViewModel.convert(value: value, from: from, to: to, completion: { [weak self] result in
                DispatchQueue.main.async {
                    switch result{
                    case .failure(let error):
                        if let result = self?.convertViewModel.convertFromBackup(value: value, from: from, to: to) {
                            if result > 0 {
                                self?.textValueOut.text = String(format: "%.2f", result)
                                self?.show(error: "Calculated from Backup", retry: false)
                                return
                            }
                        }
                       
                        if let error2 = error as? CustomError {
                            self?.show(error: error2.info, retry: false)
                        } else {
                            self?.show(error: error.localizedDescription, retry: false)
                        }
                    case .success(let value):
                        self?.textValueOut.text = String(format: "%.2f", value)
                    }
                }
            })
        }
    }
    
    func isValidaFields() -> Bool {
        if let textFrom = textFrom.text, textFrom.isEmpty {
            show(error: "textFromEmpty", retry: false)
            return false
        } else  if let textTo = textTo.text, textTo.isEmpty {
            show(error: "textToEmpty", retry: false)
            return false
        }
        else  if let textValueIn = textValueIn.text, textValueIn.isEmpty {
            show(error: "textValueInEmpty", retry: false)
            return false
        }
        return true
    }
    
    func show(error: String, retry: Bool) {
        let alert = UIAlertController(title: "Alert", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        if retry {
            alert.addAction(UIAlertAction(title: "Retry", style: UIAlertAction.Style.default)
            { action -> Void in
                self.convert(nil)
            })
        }
        self.present(alert, animated: true)
    }
}

extension ConverterViewController: ConverterViewControllerProtocol {
    func showModalCurrencyList(type: CurrencyType) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CurrencyListViewController") as! CurrencyListViewController
        viewController.delegate = self
        viewController.currencyType = type
        present(viewController, animated: true)
    }
}

extension ConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
}

extension ConverterViewController: CurrencyListViewControllerDelegate {
    func setCurrency(value: String, abreviation: String, type: CurrencyType) {
        switch type {
        case .from:
            self.from = abreviation
            textFrom.text = "\(abreviation) - \(value)"
        case .to:
            self.to = abreviation
            textTo.text = "\(abreviation) - \(value)"
        }
    }
}


