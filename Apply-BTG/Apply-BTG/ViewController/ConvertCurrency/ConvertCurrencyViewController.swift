//
//  ConvertCurrencyViewController.swift
//  Apply-BTG
//
//  Created by Adriano Rodrigues Vieira on 19/05/21.
//

import UIKit

class ConvertCurrencyViewController: UIViewController {
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var originCurrencyPicker: UIPickerView!
    @IBOutlet weak var destinyCurrencyPicker: UIPickerView!
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var convertButton: UIButton!
    
    var selectedCurrencyOriginCode: String?
    var selectedCurrencyDestinyCode: String?
        
    var currencies: [Currency] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        super.hideKeyboardWhenTappedAround()
        super.hideNavigationBar()
        
        self.setupViewElementsConfiguration()
        self.setupDelegates()
        
        self.populateCurrenciesList()
    }
        
    private func setupViewElementsConfiguration() {
        self.resultLabel.layer.borderColor = Constants.BORDER_COLOR
        self.inputTextField.layer.borderColor = Constants.BORDER_COLOR
        self.inputTextField.layer.borderWidth = Constants.BORDER_WIDTH
        self.inputTextField.textColor = Constants.FONT_COLOR
        self.inputTextField.layer.cornerRadius = Constants.CORNER_RADIUS
        
        self.resultLabel.layer.borderWidth = Constants.BORDER_WIDTH
        self.resultLabel.layer.cornerRadius = Constants.CORNER_RADIUS
        self.resultLabel.layer.borderColor =
            Constants.BORDER_COLOR
        
        self.convertButton.layer.borderColor = Constants.BORDER_COLOR
        self.convertButton.layer.borderWidth = Constants.BORDER_WIDTH
        self.convertButton.layer.cornerRadius = Constants.CORNER_RADIUS
        
        self.originCurrencyPicker.layer.cornerRadius = Constants.CORNER_RADIUS
        self.destinyCurrencyPicker.layer.cornerRadius = Constants.CORNER_RADIUS
    }
    
    private func setupDelegates() {
        self.originCurrencyPicker.dataSource = self
        self.destinyCurrencyPicker.dataSource = self
        
        self.originCurrencyPicker.delegate = self
        self.destinyCurrencyPicker.delegate = self
        
        self.inputTextField.delegate = self
    }
    
    private func populateCurrenciesList() {
        guard let safeCurrencies = UserDefaultsPersistenceManager()
                .getCurrencies(withKey: Constants.LIST_CURRENCIES_KEY) else {
            
            if NetworkManager().hasInternetConnection() {
                NetworkManager().fetchCurrenciesList { [weak self] currencies in
                    if let currencies = currencies {
                        if currencies.count != 0 {
                            self?.currencies = currencies.sorted { $0.code < $1.code }
                            self?.currencies.insert(Currency(code: Constants.BLANK_STRING, name: Constants.BLANK_STRING), at: 1)
                            
                            DispatchQueue.main.async {
                                self?.originCurrencyPicker.reloadAllComponents()
                                self?.destinyCurrencyPicker.reloadAllComponents()
                                
                                self?.originCurrencyPicker.reloadAllComponents()
                                self?.destinyCurrencyPicker.reloadAllComponents()
                            }
                        }
                    }
                }
            } else {
                self.present(AlertFactory.defaultNoInternetAlert, animated: true, completion: nil)
            }
            return
        }
        self.currencies = safeCurrencies
    }
    
    @IBAction func convertButtonTapped(_ sender: UIButton) {
        var alert: UIAlertController?
        
        if let value = Double(inputTextField.text!.replacingOccurrences(of: ",", with: ".")) {
            if let originCurrencyCode = selectedCurrencyOriginCode,
               let destinyCurrencyCode = selectedCurrencyDestinyCode {
                if originCurrencyCode == destinyCurrencyCode {
                    alert = AlertFactory.sameOriginAndDestinyAlert
                } else {
                    let convertedValue = ConversionQuotesManager()
                                            .convert(value: value,
                                                     from: originCurrencyCode,
                                                     to: destinyCurrencyCode)
                    
                    self.selectedCurrencyOriginCode = nil
                    self.selectedCurrencyDestinyCode = nil
                    
                    self.originCurrencyPicker.selectRow(0, inComponent: 0, animated: true)
                    self.destinyCurrencyPicker.selectRow(0, inComponent: 0, animated: true)                    
                    
                    resultLabel.text = ConvertCurrencyViewModel()
                        .formatCurrencyValue(convertedValue, withCode: destinyCurrencyCode)
                }
            } else {
                alert = AlertFactory.noOriginAndDestinySelectedAlert
            }
        } else {
            if selectedCurrencyDestinyCode != nil && selectedCurrencyOriginCode != nil {
                alert = AlertFactory.notNumberValidAlert
            } else {
                alert = AlertFactory.notNumberValidAndNoOriginAndDestinySelectedAlert                
            }
        }
        
        if let safeAlert = alert {
            self.present(safeAlert, animated: true)
        }
    }    
}

// MARK: - Extension for Picker
extension ConvertCurrencyViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count + 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currencies.count != 0 {
            if row > 0 {
                switch pickerView {
                case originCurrencyPicker:
                    selectedCurrencyOriginCode = currencies[row - 1].code
                        
                case destinyCurrencyPicker:
                    selectedCurrencyDestinyCode = currencies[row - 1].code
                    
                default:
                    break
                }
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
        
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: Constants.FONT_NAME,
                                       size: Constants.PICKER_VIEW_FONT_SIZE)
            pickerLabel?.textAlignment = .center
        }
        pickerLabel?.text = row == 0 ? " --- " : "\(currencies[row - 1].code) - \(currencies[row - 1].name)"
        pickerLabel?.textColor = UIColor.black
        
        return pickerLabel!
    }
}


// MARK: - Extension for text field
// // Initial idea from: https://stackoverflow.com/questions/39807386/limit-text-field-to-one-decimal-point-input-numbers-only-and-two-characters-af

extension ConvertCurrencyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                
        let currentText = textField.text ?? Constants.BLANK_STRING
        let replacementText = (currentText as NSString).replacingCharacters(in: range, with: string)

        return replacementText.isValidDecimal(maximumFractionDigits: 2)
    }
}


