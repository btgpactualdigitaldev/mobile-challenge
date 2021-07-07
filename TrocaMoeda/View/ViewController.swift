//
//  ViewController.swift
//  TrocaMoeda
//
//  Created by mac on 22/06/20.
//  Copyright © 2020 Saulo Freire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var firstCurrencyButton: UIButton!
    @IBOutlet weak var secondCurrencyButton: UIButton!
    @IBOutlet weak var amountField: CurrencyTextField!
    @IBOutlet weak var convertedField: UILabel!
    @IBOutlet weak var plusOneButton: UIButton!
    @IBOutlet weak var plusFiveButton: UIButton!
    @IBOutlet weak var plusTenButton: UIButton!
    @IBOutlet weak var plusFiftyButton: UIButton!
    @IBOutlet weak var plusHundredButton: UIButton!
    @IBOutlet weak var plusFiveHundredButton: UIButton!
    var partialAmount: Double = 0.0
    var firstSelectedCurrency: String = ""
    var secondSelectedCurrency: String = ""
    var rates: [CurrencyRateItem] = []
    let vm = CurrencyListViewModel()

    @IBAction func addToAmount(_ sender: UIButton) {
        if let numberText = sender.titleLabel?.text {
            amountField.addValue(amount: numberText)
            startConversion()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)

        let plusButtons = [plusOneButton, plusFiveButton, plusTenButton, plusFiftyButton, plusHundredButton, plusFiveHundredButton]
        plusButtons.forEach { (button) in
            button?.layer.borderWidth = 1
            button?.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
        vm.fetchCurrencies(from: K.API.currencyRatesURL, type: .CurrencyRate, completion: {
            self.rates = self.vm.rates
        }, errorHandler: ({
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Erro de Conexão", message: "Por favor, verifique sua conexão ou tente novamente mais tarde.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
                      switch action.style{
                      case .default:
                            print("default")
                      case .cancel:
                            print("cancel")
                      case .destructive:
                            print("destructive")
                      @unknown default:
                            print("end")
                    }}))
                self.present(alert, animated: true, completion: nil)
            }
        }))
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        if amountField.text != nil {
            startConversion()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
       startConversion()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destiny = segue.destination as? CurrencyListView, let button = segue.identifier {
            destiny.pressedButton = button
            if let buttonInstance = sender as? UIButton {
                if let buttonTitle = buttonInstance.titleLabel?.text {
                    destiny.pressedButtonCurrentTitle = buttonTitle
                }
            }
            
        }
    }
    
    func startConversion() {
        if let currencyAmount = amountField.text {
           if firstSelectedCurrency != "" && secondSelectedCurrency != "" && !currencyAmount.isEmpty {
            if let res = vm.calc(from: firstSelectedCurrency, to: secondSelectedCurrency, amount: currencyAmount) {
                convertedField.text = res
            }
           }
       }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        amountField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
           return true
       }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if amountField.text != nil {
            startConversion()
        }
   }
}
