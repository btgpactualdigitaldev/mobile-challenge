//
//  ViewController.swift
//  Currency Converter
//
//  Created by Gustavo on 9/30/20.
//  Copyright © 2020 Gustavo Sousa. All rights reserved.
//


// http://api.currencylayer.com/live?access_key=3e839fa4e1ee0756b657751b5a8b4277&format=1
/* "live" endpoint - request the most recent exchange rate data

 
 //3e839fa4e1ee0756b657751b5a8b4277
 
 
http://api.currencylayer.com/live

    ? access_key = YOUR_ACCESS_KEY
    & source = GBP
    & currencies = USD,AUD,CAD,PLN,MXN
    & format = 1

// Gustavo, click on the URL above to get the most recent exchange
// rates for USD, AUD, CAD, PLN and MXN


https://api.currencylayer.com/list
    ? access_key = YOUR_ACCESS_KEY

Example API Response:

{
    "success": true,
    "terms": "https://currencylayer.com/terms",
    "privacy": "https://currencylayer.com/privacy",
    "currencies": {
        "AED": "United Arab Emirates Dirham",
        "AFN": "Afghan Afghani",
        "ALL": "Albanian Lek",
        "AMD": "Armenian Dram",
        "ANG": "Netherlands Antillean Guilder",
        [...]
    }
}
 
 */

let URL_conversion: String="http://api.currencylayer.com/live?"
let URL_list: String="http://api.currencylayer.com/list?"
let accesskey: String = "access_key=3e839fa4e1ee0756b657751b5a8b4277&format=1"

import UIKit
import Foundation

class ViewController: UIViewController,UITextFieldDelegate {
    
    //Objetos para Parse Json
    struct cotacao: Codable {
        var quotes:[String:Float]
    }
    
    struct List: Codable {
        var currencies: [String:String]
    }
    
    //Variaveis da Tela
    @IBOutlet var valor: UITextField!
    @IBOutlet var fonte_button: UIButton!
    @IBOutlet var destino_button: UIButton!
    @IBOutlet var display_result: UILabel!
    
    //Variaveis do Picker List
    @IBOutlet var picker: UIPickerView!
    @IBOutlet var toolbar: UIImageView!
    @IBOutlet var toolbar_display: UILabel!
    @IBOutlet var ok_button: UIButton!
   
    //Dictionary e Arrays Globais Essenciais
    var dict_lista:[String:String]?
    var dict_quote:[String:Float]?
    var arr_moeda:[String]?
    
    //Ao iniciar fazemos o download dos dados JSON
    override func viewDidLoad() {
        super.viewDidLoad()
        esconder()
        convert_currency()
        obtain_list()
    }
    
    //Para inciar o mais logo as bordas do text e do label
    override func viewDidAppear(_ animated: Bool) {
        valor.layer.borderColor = UIColor.black.cgColor
                      valor.layer.borderWidth=2.0
          display_result.layer.borderColor = UIColor.black.cgColor
            display_result.layer.borderWidth=2.0
    }
    
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        esconder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        esconder()
    }
    
    @IBAction func desapareceteclado(_ sender: Any) {
        valor.resignFirstResponder()
    }
    
    func esconder(){
        self.picker.isHidden=true
        self.toolbar_display.isHidden=true
        self.toolbar.isHidden=true
        self.ok_button.isHidden=true
    }
    
    func aparecer() {
        self.picker.isHidden=false
        self.toolbar_display.isHidden=false
        self.toolbar.isHidden=false
        self.ok_button.isHidden=false
    }
    
    
    //Quando clica no botao da moeda fonte
    @IBAction func original(_ sender: Any) {
        aparecer()
        valor.resignFirstResponder()
        picker.reloadAllComponents()
        self.toolbar_display.text="Moeda Fonte"
    }
    
    //Quando clica no botao da moeda destino
    @IBAction func result(_ sender: Any) {
        aparecer()
        valor.resignFirstResponder()
        picker.reloadAllComponents()
        self.toolbar_display.text="Moeda Destino"
    }
    
    //Qunado clica OK no toolbar do PickerView
    @IBAction func OK(_ sender: Any) {
        if(toolbar_display.text=="Moeda Fonte"){
            if(fonte_button.currentTitle != "USD" && destino_button.currentTitle != "USD"){
                destino_button.setTitle("USD", for: .normal)
            }
        } else {
            if(destino_button.currentTitle != "USD" && fonte_button.currentTitle != "USD"){
                   fonte_button.setTitle("USD", for: .normal)
               }
        }

        valor.resignFirstResponder()
        esconder()
 
    }
    
    @IBAction func calc(_ sender: Any) {
        esconder()
        self.calcular()
    }
    
   
    //Metodo para obtair o Dictionary das cotações
    func convert_currency(){
    
    let URLString = URL_conversion + accesskey
    let url=URL(string: URLString)
    print(URLString)
    guard url != nil else{
        print("URL não existe")
        return
    }
    
    let session=URLSession.shared
    let dataTask = session.dataTask(with:url!){ (data, response, error) in
      if error == nil && data != nil {
            let decoder = JSONDecoder()
        do {
            let tabela = try decoder.decode(cotacao.self, from: data!)
            self.dict_quote = tabela.quotes
            print("Teste:\n \(cotacao.self)")
            print(self.dict_quote!)
           }
         catch {
             print("Falha ao carregar arquivo JSON")
        }
      }
    }
    
    dataTask.resume()
    }
 
   // Metodo para obter List de Moedas, armazenando em Dictionaries e Arrays
   func obtain_list(){
   
   let URLString = URL_list + accesskey
   let url=URL(string: URLString)
   
    print(URLString)
   guard url != nil else{
       print("URL não existe")
       return
   }
   
   let session=URLSession.shared
      let dataTask = session.dataTask(with:url!){ (data, response, error) in
        if error == nil && data != nil {
              let decoder = JSONDecoder()
          do {
              let tabela = try decoder.decode(List.self, from: data!)
              self.dict_lista = tabela.currencies
              self.arr_moeda = Array(self.dict_lista!.values)
              print("Teste:\n \(List.self)")
              print(self.dict_lista!)
             }
           catch {
               print("Falha ao carregar arquivo JSON")
          }
        }
      }
      dataTask.resume()
      }
    
    //Metodo quando clica no botao calcular
    func calcular(){
           
           let fonte: String=self.fonte_button.currentTitle!
           let destino:String=self.destino_button.currentTitle!
           let input=Float(valor.text!)
           
           if(input==nil) {return}
           
           var cotacao: Float
           var tipo:String
           
           if(fonte_button.currentTitle=="USD"){
               tipo="\(fonte)\(destino)"
               cotacao=dict_quote![tipo]!*input!
           } else {
               tipo="\(destino)\(fonte)"
               cotacao=input!/dict_quote![tipo]!
               
           }
           display_result.text=String(format:"%.2f",cotacao)
     
       }
}


//Metodos do PickerView
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dict_lista?.count ?? 20
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arr_moeda?[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let titulo:String=Array(dict_lista!.keys)[row]
        
        print(titulo)
        if (toolbar_display.text=="Moeda Fonte"){
            fonte_button.setTitle(titulo, for: .normal)
        } else {
            destino_button.setTitle(titulo, for: .normal)
        }
    }
    
    
}


