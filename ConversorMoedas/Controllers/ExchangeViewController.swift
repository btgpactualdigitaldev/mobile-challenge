//
//  CotacaoViewController.swift
//  ConversorMoedas
//
//  Created by Ricardo Santana Lopes on 11/08/20.
//  Copyright © 2020 Ricardo Santana Lopes. All rights reserved.
//

import UIKit

class ExchangeViewController: UIViewController{

    var currencyOrigin: (key:String,value:String)?
    var currencyDestiny: (key:String,value:String)?
    var isButtonOriginTaped: Bool = false

    @IBAction func didTapOriginButton(_ sender: Any) {
        openCurrenciesList()
        isButtonOriginTaped = true
    }
    
    @IBAction func didTapChangeCurrencies(_ sender: Any) {
        let currencyAux = currencyOrigin
        currencyOrigin = currencyDestiny
        currencyDestiny = currencyAux
        
        let btOriginTitle = btOrigin.currentTitle ?? "Moeda Origem"
        let btDestinyTitle = btDestiny.currentTitle ?? "Moeda Destino"
        btOrigin.setTitle("\(btDestinyTitle)", for: .normal)
        btDestiny.setTitle("\(btOriginTitle)", for: .normal)
       
        
    }
    
    @IBAction func didTapDestinyButton(_ sender: Any) {
        openCurrenciesList()
        isButtonOriginTaped = false
    }
    
    @IBAction func didTapToConvert(_ sender: Any) {
        
        
        
        let title = "Atenção"
        
        if ((currencyOrigin?.key) == nil){
            let message = "Escolha uma moeda de origem"
            showMessage(title, message)
            return
        }
        
        if ((currencyDestiny?.key) == nil){
            let message = "Escolha uma moeda de destino"
            showMessage(title, message)
            return
        }
        
        if let valueConvert = tfInputValue.text, valueConvert.isEmpty{
            let message = "Preencha o valor a ser convertido"
            showMessage(title, message)
            return
        }
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        let valueToConvert = formatter.number(from: tfInputValue?.text ?? "0.0")

        Exchange().getLive(currencyOrigin?.key ?? "", currencyDestiny?.key ?? "", valueToConvert as! Double, { result in
        DispatchQueue.main.async {
            self.lbResult?.text = formatter.string(from: NSNumber(value: result))
                }
        }, {error in
            let title = "Erro"
            self.showMessage(title, error as! String)
        } )
       
    }
    
    @IBOutlet weak var btOrigin: UIButton!
    @IBOutlet weak var btDestiny: UIButton!
    @IBOutlet weak var tfInputValue: UITextField!
    @IBOutlet weak var lbResult: UILabel!
    
    func setCurrency(_ currency: (key:String,value:String)) {
        
        if(isButtonOriginTaped){
            currencyOrigin = currency
            btOrigin.setTitle("\(currency.key) - \(currency.value)", for: .normal)
        }else{
            currencyDestiny = currency
            btDestiny.setTitle("\(currency.key) - \(currency.value)", for: .normal)
        }
    }
    
    private func openCurrenciesList() {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "list")
        present(vc, animated: true, completion: nil)
    }
}
