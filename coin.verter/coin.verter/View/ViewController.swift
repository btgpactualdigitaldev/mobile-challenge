//
//  ViewController.swift
//  coin.verter
//
//  Created by Caio Berkley on 21/06/20.
//  Copyright © 2020 Caio Berkley. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK - Variables
    var controller : CurrencyController?
    
    // MARK - Outlets
    @IBOutlet weak var inputCurrencyButton: UIButton!
    @IBOutlet weak var resultCurrencyButton: UIButton!
    @IBOutlet weak var inputCurrencyLabel: UILabel!
    @IBOutlet weak var resultCurrencyLabel: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var cleanCurrencyButton: UIButton!
    @IBOutlet weak var pointButton: UIButton!
    @IBOutlet weak var convertCurrencyButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.controller = CurrencyController()

        self.controller?.setupViewController()
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
    }
    
    // MARK - Actions
    
    @IBAction func inputCurrencyButtonTapped(_ sender: Any) {
        
        let listView = storyboard?.instantiateViewController(identifier: "currencyList") as! CurrencyListTableTableViewController
        
        listView.didSelectValue = { (selectedCurrency) in
            self.inputCurrencyButton.setTitle(selectedCurrency, for: .normal)
        }
        
        present(listView,animated: true)
        
    }
    
    @IBAction func resultCurrencyButtonTapped(_ sender: Any) {
        
        let listView = storyboard?.instantiateViewController(identifier: "currencyList") as! CurrencyListTableTableViewController
        
        listView.didSelectValue = { (selectedCurrency) in
            self.resultCurrencyButton.setTitle(selectedCurrency, for: .normal)
        }
        
        present(listView,animated: true)
        
    }
    
    @IBAction func helpButtonTapped(_ sender: Any) {
        
        let mensagem = "Deseja contatar o desenvolvedor via WhatsApp?"
        let alert = UIAlertController(title: "Alguma dúvida?", message: mensagem, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Depois", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if (action.style == .default){
                if let url = URL(string: "https://wa.me/5513981953015?text=BTG%20Digital:%20Parab%C3%A9ns!%20Voc%C3%AA%20foi%20selecionado%20para%20a%20vaga%20de%20Desenvolvedor%20iOS!"), UIApplication.shared.canOpenURL(url) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url)
                    }
                    else {
                        UIApplication.shared.openURL(url)
                    }
                }
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func cleanCurrencyButtonTapped(_ sender: Any) {
        inputCurrencyLabel.text = "0"
        resultCurrencyLabel.text = "0"
    }
    
    @IBAction func digitButtonTapped(_ sender: UIButton) {
        
        //MARK - Get the tapped number
        guard let inputString : String = sender.titleLabel?.text else {return}
        guard let currentInput = inputCurrencyLabel.text else {return}
        
        if currentInput == "0" {
            guard inputString == "." else {inputCurrencyLabel.text = "\(inputString)"; return }
                inputCurrencyLabel.text = "\(currentInput)\(inputString)"
        } else {
            guard currentInput.contains(".") && inputString == "." else {inputCurrencyLabel.text = "\(currentInput)\(inputString)"; return }
                    return
        }
    }
    
    @IBAction func convertCurrencyButtonTapped(_ sender: Any) {
        
        guard let amount = Double(self.inputCurrencyLabel.text!) else { return }
        
        guard let inputCurrency = inputCurrencyButton.titleLabel?.text else { return }
        guard let resultCurrency = resultCurrencyButton.titleLabel?.text else { return }
            
            controller?.getCurrencyExchange(closure: { (conversion) in
                print(conversion)
                
                DispatchQueue.main.async {
                    
                    let formatter = NumberFormatter()
                    formatter.locale = Locale.autoupdatingCurrent
                    formatter.numberStyle = .decimal
                    if let formattedAmount = formatter.string(from: Double(round(100*conversion)/100) as NSNumber) {
                        self.resultCurrencyLabel.text = String(formattedAmount)
                    }
                }
                
            }, amount: amount, from: inputCurrency, to: resultCurrency)
    }
}
