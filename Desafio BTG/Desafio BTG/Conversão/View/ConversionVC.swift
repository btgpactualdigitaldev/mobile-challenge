//
//  ConversionVC.swift
//  Desafio BTG
//
//  Created by Vinícius Brito on 24/05/20.
//  Copyright © 2020 Vinícius Brito. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ConversionVC: UIViewController {
    
    @IBOutlet weak var initialValueTextField: UITextField!
    @IBOutlet weak var fromCurrencyTextField: UITextField!
    @IBOutlet weak var toCurrencyTextField: UITextField!
    @IBOutlet weak var clearFieldsButton: UIButton!
    @IBOutlet weak var convertedValueLabel: UILabel!
    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let currenciesVC = "CurrenciesVC"
    
    var tapFromCurrency = UITapGestureRecognizer()
    var tapToCurrency = UITapGestureRecognizer()
    var currencyList = Currency()
    var liveValues = [String:JSON]()
    var valueConvertedToDollar = Float()
    var finalValue = Float()
    
    // MARK: - <Lifecycle>

    override func viewDidLoad() {
        super.viewDidLoad()

        gestureForTextFields()
        self.hideKeyboardWhenTappedAround()
        getCurrenciesList()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
    // MARK: - <IBActions>
    
    @IBAction func clearFields(_ sender: Any) {
        cleanFields()
    }
    
    @IBAction func convertAction(_ sender: Any) {
        getLive()
    }
    
    @IBAction func refreshDataFromServer(_ sender: Any) {
        refreshButton.isEnabled = false
        getCurrenciesList()
    }
    
    // MARK: - <Methods>
    
    /*
     GestureRecognizer
     */
    func gestureForTextFields() {
        tapFromCurrency = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        tapFromCurrency.numberOfTapsRequired = 1
        tapFromCurrency.numberOfTouchesRequired = 1
        fromCurrencyTextField.addGestureRecognizer(tapFromCurrency)
        fromCurrencyTextField.isUserInteractionEnabled = true
        addDoneOnInitialTextField()
        
        tapToCurrency = UITapGestureRecognizer(target: self, action: #selector(textFieldTapped))
        tapToCurrency.numberOfTapsRequired = 1
        tapToCurrency.numberOfTouchesRequired = 1
        toCurrencyTextField.addGestureRecognizer(tapToCurrency)
        toCurrencyTextField.isUserInteractionEnabled = true
    }
    
    @objc func textFieldTapped(_ sender: UITapGestureRecognizer) {

        if let currenciesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: currenciesVC) as? CurrenciesVC {
            currenciesVC.delegate = self
            currenciesVC.currencyList = self.currencyList
            
            if sender == tapFromCurrency {
                currenciesVC.isFromCurrency = true
            }
            
            animationOnTransition(viewController: currenciesVC)
        }
    
    }
    
    /*
     Animation on screen transtition.
     */
    func animationOnTransition(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType(rawValue: "flip")
        transition.subtype = CATransitionSubtype.fromLeft
        self.navigationController?.view.layer.add(transition, forKey: kCATransition)
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    /*
     Make a request to API in order to get list of currencies then hold the value to populate TableView.
     */
    func getCurrenciesList() {
        activityIndicator.startAnimating()
        Webservice.getCurrenciesList { (success, json) in
            
            if let json = json {
                
                if json["success"].boolValue {
                    // We're ok to parse
                    
                    let currency = Currency.parseList(json: json)
                    self.currencyList = currency
                    self.refreshButton.isEnabled = true
                    self.activityIndicator.stopAnimating()
                } else {
                    let message = json["error"]["info"].stringValue
                    self.alertJSON(message: message)
                    self.refreshButton.isEnabled = true
                    self.activityIndicator.stopAnimating()
                }
            } else {
                print("Parsing error, check API!!!!")
                self.refreshButton.isEnabled = true
                self.activityIndicator.stopAnimating()
            }
            
        }
        
    }
    
    /*
     Get the most recent exchange rate data
     */
    func getLive() {
        Webservice.getLive { (success, json) in
            if let json = json {
                self.liveValues = json["quotes"].dictionaryValue
                self.checkForEmptyFields()
            } else {
                self.alertJSON(message: "Something went wrong ;( Please try again in a few minutes.")
            }
        }
    }
    
    /*
     Checking for empty fields making them to becomeFirstResponder accordingly.
     */
    func checkForEmptyFields() {
        if initialValueTextField.text!.count <= 0 ||
           initialValueTextField.text == "" {
            alert(message: "#1 Field must NOT be empty, please type a value.", textField: initialValueTextField)
        } else if fromCurrencyTextField.text!.count <= 0 ||
                  fromCurrencyTextField.text == "" {
            alert(message: "#2 Field must NOT be empty, please select a value.", textField: fromCurrencyTextField)
        } else if toCurrencyTextField.text!.count <= 0 ||
            toCurrencyTextField.text == "" {
            alert(message: "#3 Field must NOT be empty, please select a value", textField: toCurrencyTextField)
        } else {
            convertValueToDollar(quotes: self.liveValues)
        }
    }
    
    /*
     Alert for handling TextFields.
     */
    func alert(message: String, textField: UITextField) {
        let alertController = UIAlertController(title: "Oops!",
                                                message: message,
                                                preferredStyle: .alert)
        let ok = UIAlertAction(title: "Got it",
                               style: .default) { (UIAlertAction) in
                                
                                if textField == self.initialValueTextField {
                                    textField.becomeFirstResponder()
                                } else {
                                    if let currenciesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: self.currenciesVC) as? CurrenciesVC {
                                        currenciesVC.delegate = self
                                        currenciesVC.currencyList = self.currencyList
                                        
                                        if textField == self.fromCurrencyTextField {
                                            currenciesVC.isFromCurrency = true
                                        }
                                        
                                        self.animationOnTransition(viewController: currenciesVC)
                                    }
                                }
        }
        
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
    Alert for JSON.
    */
    func alertJSON(message: String) {
        let alertController = UIAlertController(title: "Oops!",
                                                message: message,
                                                preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK",
                               style: .default,
                               handler: { (UIAlertAction) in
                                self.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(ok)
        self.present(alertController, animated: true, completion: nil)
    }
    
    /*
     Convert the value input by user into USD American Dollar.
     */
    func convertValueToDollar(quotes: [String:JSON]) {
        let currencyFrom = getCodeFromCurrency(text: fromCurrencyTextField.text!)
        
        for (key, value) in quotes {
            if currencyFrom == key {
                if let initVal = Float(initialValueTextField.text!) {
                    valueConvertedToDollar = initVal / Float(value.floatValue)
                    finalValue(quotes: quotes, valueDollar: valueConvertedToDollar)
                } else {
                }
            }
        }
        
    }
    
    /*
     Convert the value as USD American Dollar into desired currency.
     */
    func finalValue(quotes: [String:JSON], valueDollar: Float) {
        
        let currencyTo = getCodeFromCurrency(text: toCurrencyTextField.text!)
        
        if currencyTo == "USDUSD" {
            convertedValueLabel.text = "\(valueConvertedToDollar)"
        } else {
            for (key, value) in quotes {
                if currencyTo == key {
                    finalValue = valueDollar * value.floatValue
                    convertedValueLabel.text = "\(finalValue)"
                }
                
            }
        }
        
    }
    
    /*
     Get currency code for camparison.
     */
    func getCodeFromCurrency(text: String) -> String {
        let currencyCode = String(text.prefix(3))
        let code = "USD\(currencyCode)"
        return code
    }
    
    /*
     Clean TextFields and Label.
     */
    func cleanFields() {
        initialValueTextField.text = ""
        fromCurrencyTextField.text = ""
        toCurrencyTextField.text = ""
        convertedValueLabel.text = ""
    }
    
    /*
     Add Done button on initialTexfield.
     */
    func addDoneOnInitialTextField() {
        
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(doneButtonAction))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: false)
        toolbar.sizeToFit()
        
        initialValueTextField.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
}

// MARK: - <CurrenciesVCDelegate>

extension ConversionVC: CurrenciesVCDelegate {
    
    func updateTextFields(text: String, bool: Bool) {
        if bool {
            fromCurrencyTextField.text = text
        } else {
            toCurrencyTextField.text = text
        }
    }
    
}

// MARK: - <UITextField>

extension CurrenciesVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - <Dismiss textField tapping anywhere on screen>

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
