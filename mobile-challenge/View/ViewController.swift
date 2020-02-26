//
//  ViewController.swift
//  mobile-challenge
//
//  Created by Alan Silva on 10/02/20.
//  Copyright © 2020 Alan Silva. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {
    
    @IBOutlet weak var fromPickerView: UIPickerView!
    @IBOutlet weak var toPickerView: UIPickerView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var btnExchange: UIButton!
    @IBOutlet weak var currencyDescription: UILabel!
    
    private var selectedFrom : String?
    private var selectedTo : String?
    
    var controller : CurrencyController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.formatUI()
        
        self.controller = CurrencyController()
        
        self.controller?.delegate = self
        
        //self.controller?.setupCurrencyListViewController()
        self.controller?.setupViewController()
        
        //Delegate and DataSource of PickerViews
        self.fromPickerView.delegate = self
        self.fromPickerView.dataSource = self
        self.toPickerView.delegate = self
        self.toPickerView.dataSource = self
        
        self.amountTextField.delegate = self
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
    }
    
    @IBAction func btnClearScreen(_ sender: UIButton) {
    
        clearFields()
        
    }
    
    func clearFields(){
        
        self.currencyDescription.text = ""
        self.resultLabel.text = ""
        self.amountTextField.text = ""
        //self.fromPickerView.setNeedsLayout()
        
    }
    
    func formatUI(){
        
        self.amountTextField.keyboardType = .numbersAndPunctuation
        
        btnExchange.layer.cornerRadius = 10
        btnExchange.layer.borderWidth = 1
        btnExchange.layer.borderColor = UIColor.black.cgColor
        
    }
    
    @IBAction func btnGetExchange(_ sender: UIButton) {
        
        guard let amount = Double(self.amountTextField.text!) else {
            
            showAlert(title: "Atenção", msg: "Informe o valor a ser convertido!", style: .alert)
            
            return
            
        }
        
        guard let from = self.selectedFrom else {
            
            showAlert(title: "Atenção", msg: "Informe a moeda de origem!", style: .alert)
            
            return
            
        }
        
        guard let to = self.selectedTo else {
            
            showAlert(title: "Atenção", msg: "Informe a moeda de destino!", style: .alert)
            
            return
            
        }
        
        if from == to {
            
            showAlert(title: "Atenção", msg: "Moedas não podem ser iguais!", style: .alert)
            
            return
            
        }else {
            
            startActivityIndicator()
            
            controller?.getCurrencyExchange(closure: { (conversion) in
                print(conversion)
                
                DispatchQueue.main.async {
                    
                    let formatter = NumberFormatter()
                    formatter.locale = Locale.autoupdatingCurrent
                    formatter.numberStyle = .decimal
                    if let formattedAmount = formatter.string(from: Double(round(100*conversion)/100) as NSNumber) {
                        self.resultLabel.text = String(formattedAmount)
                    }
                    self.currencyDescription.text = self.controller?.getNameOfCurrencyWithCode(code: to)
                    self.stopActivityIndicator()
                }
                
            }, amount: amount, from: from, to: to)
            
        }
        
    }
    
}

extension ViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.controller?.getNumberOfRowsInSection() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.controller?.loadCurrencyTitleForRow(with: row)
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //CRIAR UM DELEGAT PARA OUVIR QUANDO HOUVER ALTERACAO
        
        switch pickerView.tag {
        case 0 :
            self.selectedFrom = self.controller?.loadCurrencyTitleForRow(with: row)
        case 1:
            self.selectedTo = self.controller?.loadCurrencyTitleForRow(with: row)
        default:
            return
        }
        
    }
    
}

//MARK: - EXTENSION OF CurrencyControllerDelegate

extension ViewController : CurrencyControllerDelegate {
    
    func successOnLoadingListOfCurrencies() {
        
        DispatchQueue.main.async {
            
            self.fromPickerView.reloadAllComponents()
            self.toPickerView.reloadAllComponents()
            
        }
        
    }
    
    func errorOnLoadingListOfCurrencies(error: CurrencyError) {
        
        if !error.localizedDescription.isEmpty {
            
            DispatchQueue.main.async {
                
                let alerta = UIAlertController(title: "Erro", message: "Problema ao carregar os dados dos moedas", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                
                alerta.addAction(btnOk)
                
                self.present(alerta, animated: true)
                
                self.resultLabel.text = ""
                self.currencyDescription.text = ""
                
                //SE HOUVER ERRO, CARREGAR DO COREDATA
                self.fromPickerView.reloadAllComponents()
                self.toPickerView.reloadAllComponents()
                
                self.stopActivityIndicator()
            }
            
        }
        
    }
    
    func timeToStopActivity(resp: Bool) {
        
        switch resp {
        case false:
            DispatchQueue.main.async {
                self.stopActivityIndicator()
            }
        case true:
            
            DispatchQueue.main.async {
                
                self.stopActivityIndicator()
                
                let alerta = UIAlertController(title: "Sem conexão!", message: "Não foi possivel obter os dados", preferredStyle: .alert)
                let btnOk = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                alerta.addAction(btnOk)
                self.present(alerta, animated: true)
                
                self.fromPickerView.isUserInteractionEnabled = false
                self.toPickerView.isUserInteractionEnabled = false
            }
            
        }
        
    }
    
}

//MARK: - EXTENSION OF UITextFieldDelegate
extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.amountTextField {
            
            self.amountTextField.resignFirstResponder()
            
        }
        
        return true
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField == self.amountTextField){
            let strLength = textField.text?.count ?? 0
            let lngthToAdd = string.count
            let lengthCount = strLength + lngthToAdd
            
            if lngthToAdd == 0 && lengthCount == 1 {
                self.amountTextField.text = ""
                self.amountTextField.resignFirstResponder()
                
            }
            
        }
        
        return true
        
    }
    
}
