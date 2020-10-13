//
//  CurrencyConvertViewController.swift
//  currency-converter
//
//  Created by Rodrigo Queiroz on 09/10/20.
//

import UIKit

class CurrencyConvertViewController: UIViewController, UITextFieldDelegate {
    
    
    //MARK: Outlets
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var lblConvertedAmount: UITextView!
    @IBOutlet weak var btnOriginCurrency: UIButton!
    @IBOutlet weak var btnTargetCurrency: UIButton!
    
    var userDefault = UserDefaults.standard
    var currentString = String()
    var quotes: [CurrencyQuotes] = []
    
    private var service: ApiService!
    
    //MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.service = ApiService()
        
        txtAmount.delegate = self
        checkCurrencyType()
        
        setLayout()
        loadCurrencyValues()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let viewCtrl = segue.destination as! ListCurrencyViewController
        viewCtrl.delegate = self
        viewCtrl.currencyType = (sender as! Constants.CurrencyType)
        
    }
    
    
    //MARK: Functions
    func loadCurrencyValues() {
        
        self.service.getCurrencyValues {
            
            (response) in
            
            if response.success {
                
                for item in response.quotes {
                    self.quotes.append(CurrencyQuotes(item.key, item.value))
                    
                }
                
            } else {
                
            }
            
        }
        
    }
    
    func setLayout() {
        
        let toolBar =  UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        toolBar.barStyle = .default
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        toolBar.items = [doneButton]
        toolBar.isUserInteractionEnabled = true
        txtAmount.inputAccessoryView = toolBar
        
        btnOriginCurrency.layer.cornerRadius = 8
        btnTargetCurrency.layer.cornerRadius = 8
        
    }
    
    func checkCurrencyType() {
        
        if let origin = userDefault.string(forKey: Constants.CurrencyType.origin.rawValue) {
            
            let title = "Origin Currency (\(origin))"
            
            btnOriginCurrency.setTitle(title, for: .normal)
            
        }
        
        if let target = userDefault.string(forKey: Constants.CurrencyType.target.rawValue) {
            
            let title = "Target Currency (\(target))"
            
            btnTargetCurrency.setTitle(title, for: .normal)
            
        }
        
    }
    
    func setCurrency(_ currencyInfo: CurrencyInfo)  {
        
        userDefault.setValue(currencyInfo.initial, forKey: currencyInfo.currencyType!.rawValue)
        
        checkCurrencyType()
        
        if let _ = userDefault.string(forKey: Constants.CurrencyType.origin.rawValue)
           , let _ = userDefault.string(forKey: Constants.CurrencyType.target.rawValue)
           , !txtAmount.text!.isEmpty {
            convertCurrency()
        }
        
    }
    
    func convertCurrency() {
        
        if (txtAmount.text!.isEmpty || Float(txtAmount.text!) == 0) {
            showAlert("The conversion value cannot be empty or zero.")
            return
        }
        
        if let origin = userDefault.string(forKey: Constants.CurrencyType.origin.rawValue)
           , let target = userDefault.string(forKey: Constants.CurrencyType.target.rawValue) {
            
            let quoteCod: String = "USD\(target)"
            let valueConvert = Float(txtAmount.text!)
            
            if quotes.count > 0 {
                
                if origin == "USD" {
                    
                    let quote = quotes.filter({ $0.cod == quoteCod })
                    
                    let newValue = valueConvert! * quote[0].amount
                    
                    lblConvertedAmount.text = String(format: "%.2f", newValue)
                    lblConvertedAmount.isHidden = false
                    
                } else if target == "USD" {
                    
                    let quoteUSD = quotes.filter({ $0.cod == "USD\(origin)" })
                    let USDValue = valueConvert! / quoteUSD[0].amount
                    
                    lblConvertedAmount.text = String(format: "%.2f", USDValue)
                    lblConvertedAmount.isHidden = false
                    
                } else {
                    
                    let quoteUSD = quotes.filter({ $0.cod == "USD\(origin)" })
                    let quoteTarget = quotes.filter({ $0.cod == "USD\(target)" })
                    
                    let USDValue = valueConvert! / quoteUSD[0].amount
                    
                    let finalValue = USDValue * quoteTarget[0].amount
                    
                    
                    lblConvertedAmount.text = String(format: "%.2f", finalValue)
                    lblConvertedAmount.isHidden = false
                    
                }
                
            }
            
        } else {
            showAlert("Enter the currencies for conversion")
        }
        
    }
    
    func showAlert(_ msg: String) {
        
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: .alert)
        alert.addAction(confirmAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @objc func doneButtonTapped() {
        txtAmount.resignFirstResponder()
        convertCurrency()
    }
    
    //MARK: Actions
    @IBAction func changeCurrency(_ sender: UIButton) {
        
        let currencyType = (sender.currentTitle?.contains("Origin Currency"))! ? Constants.CurrencyType.origin : .target
        
        performSegue(withIdentifier: "segueListCurrencies", sender: currencyType)
        
    }
    
    //MARK: TextField Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
        
        if string.count == 0 {
            return true
        }
        
        let userEnteredString = textField.text ?? ""
        
        var newString = (userEnteredString as NSString).replacingCharacters(in: range, with: string) as NSString
        newString = newString.replacingOccurrences(of: ".", with: "") as NSString
        
        let centAmount : NSInteger = newString.integerValue
        let amount = (Double(centAmount) / 100.0)
        
        if newString.length < 16 {
            let str = String(format: "%0.2f", arguments: [amount])
            txtAmount.text = str
        }
        
        return false
    }
    
}

extension CurrencyConvertViewController: SelectedCurrencyDelegate {
    
    func setSelectedCurrency(_ currency: CurrencyInfo) {
        self.setCurrency(currency)
        
    }
    
    
}

